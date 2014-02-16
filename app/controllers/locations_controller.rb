class LocationsController < ApplicationController
	before_action :set_datastore
	before_action :set_location, only: [:show, :edit, :update, :destroy]


	def new
		@location = @datastore.locations.build
	end

	def create
		@location = @datastore.locations.build(location_params)
		if @location.save
			flash[:notice] = "Location has been created."
			redirect_to [@datastore, @location]
		else
			flash[:alert] = "Location has not been created."
			render "new"
		end
	end
	
	def show
	end

	def edit
	end

	def update
		if @location.update(location_params)
			flash[:notice] = "Location has been updated."
			redirect_to [@datastore, @location]
		else
			flash[:alert] = "Location has not been updated."
			render action: "edit"
		end
	end

	private
	def set_datastore
		@datastore = Datastore.find(params[:datastore_id])
	end

	def set_location
		@location = @datastore.locations.find(params[:id])
	end

	def location_params
		params.require(:location).permit(:name, :path, :last_modified)
	end
end
