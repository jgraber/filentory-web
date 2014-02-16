class LocationController < ApplicationController
	def new
		@location = @datastore.locations.build
	end
end
