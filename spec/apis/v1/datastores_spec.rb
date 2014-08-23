require "spec_helper"
require "rack/test"

describe "/api/v1/datastores", :type => :api do 
  let!(:user) { FactoryGirl.create(:user) }
  let!(:token) { user.authentication_token }
  let!(:datastore) { FactoryGirl.create(:datastore) }
  let(:url) { "/api/v1/datastores" }

  context "projects viewable by this user" do
    it "json" do 
      get "#{url}.json", :token => token, :user_email => user.email
      
      datastores_json = Datastore.all.to_json
      last_response.body.should eql(datastores_json)
      last_response.status.should eql(200)
      
      datastores = JSON.parse(last_response.body)
      
      datastores.any? do |ds|
        ds["name"] == datastore.name
      end
    end
  end

  context "show error when credentials are missing" do
    it "misses email and token" do
      get "#{url}.json"

      error = "{\"error\":\"You need to sign in or sign up before continuing.\"}"
      last_response.body.should eql(error)
      last_response.status.should eql(401)
    end
  end

  context "creating a project" do
    let(:doc) { IO.read(Rails.root.join("spec", "fixtures", "files", "cli_full.json")) }

    it "successful JSON" do
      post "#{url}.json", :token => token,
                          :user_email => user.email,
                          :datastore => {
                            :name => "Inspector"
                          }

      ds = Datastore.find_by_name!("Inspector")
      route = "/api/v1/datastores/#{ds.id}"
      last_response.status.should eql(201)

      last_response.headers["Location"].should eql(route)
      last_response.body.should eql(ds.to_json)
    end

    it "misses a name" do
      post "#{url}.json", :token => token,
                          :user_email => user.email,
                          :datastore => {
                            :mediatype => "DVD"
                          }

      last_response.status.should eql(422)              
      last_response.body.should eql ('{"errors":{"name":["can\'t be blank"]}}')
    end

    it "can use filentory-cli output" do
      post "#{url}.json", :token => token,
                          :user_email => user.email,
                          :data => doc
      ds = Datastore.find_by_name!("testrun")
      route = "/api/v1/datastores/#{ds.id}"
      last_response.status.should eql(201)

      last_response.headers["Location"].should eql(route)
      last_response.body.should eql(ds.to_json)

      get "/api/v1/datastores/#{ds.id}.json", :token => token, :user_email => user.email
      
      store_response = JSON.parse(last_response.body)
      #puts store_response["locations"]
      
      first_location_name = store_response["locations"][0]["name"]
      first_location_name.should eql("fileA.txt")

      #puts JSON.parse(store_response["files"])[0][0]["name"]
      #puts "-----"
      #puts JSON.parse(store_response["files"])[2]

      files = JSON.parse(store_response["files"])
      first_file = files[0][0]
      first_file["name"].should eql("fileA.txt")

      last_file = files[2][0]
      last_file["name"].should eql("video.mov")

      files[2][1]["key"].should eql("audio_bitrate")
    end
  end

end
