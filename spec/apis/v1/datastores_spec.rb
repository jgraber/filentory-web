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
      expect(last_response.body).to eql(datastores_json)
      expect(last_response.status).to eql(200)
      
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
      expect(last_response.body).to eql(error)
      expect(last_response.status).to eql(401)
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
      expect(last_response.status).to eql(201)

      expect(last_response.headers["Location"]).to eql(route)
      expect(last_response.body).to eql(ds.to_json)
    end

    it "misses a name" do
      post "#{url}.json", :token => token,
                          :user_email => user.email,
                          :datastore => {
                            :mediatype => "DVD"
                          }

      expect(last_response.status).to eql(422)              
      expect(last_response.body).to eql ('{"errors":{"name":["can\'t be blank"]}}')
    end

    it "can use filentory-cli output" do
      post "#{url}.json", :token => token,
                          :user_email => user.email,
                          :data => doc
      ds = Datastore.find_by_name!("testrun")
      route = "/api/v1/datastores/#{ds.id}"
      expect(last_response.status).to eq(201)

      expect(last_response.headers["Location"]).to eql(route)
      expect(last_response.body).to eq(ds.to_json)

      get "/api/v1/datastores/#{ds.id}.json", :token => token, :user_email => user.email
      
      store_response = JSON.parse(last_response.body)
      #puts store_response["locations"]
      
      first_location_name = store_response["locations"][0]["name"]
      expect(first_location_name).to eq("fileA.txt")

      #puts JSON.parse(store_response["files"])[0][0]["name"]
      #puts "-----"
      #puts JSON.parse(store_response["files"])[2]

      files = JSON.parse(store_response["files"])
      first_file = files[0][0]
      expect(first_file["name"]).to eql("fileA.txt")

      last_file = files[2][0]
      expect(last_file["name"]).to eql("video.mov")

      expect(files[2][1]["key"]).to eql("audio_bitrate")
    end
  end

end
