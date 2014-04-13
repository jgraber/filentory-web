require 'rspec'
require "rack/test"

module ApiHelper
  include Rack::Test::Methods

  def app
    Rails.application
  end
end

RSpec.configure do |c|
  c.include ApiHelper, :type => :api # only works when using spec/api_s_ with an s!
end

RSpec.configure do |conf|
  conf.include Rack::Test::Methods, :type => :api 
end