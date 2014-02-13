class DatastoresController < ApplicationController
	before_action :set_datastore, only: [:show, :edit, :update, :destroy]


	def index
		@datastores = Datastore.all
	end

	def new
		@datastore = Datastore.new
	end

	def create
		@datastore = Datastore.new(datastore_params)
		if @datastore.save
			flash[:notice] = "Datastore has been created."
			redirect_to @datastore 
		else
			flash[:alert] = "Datastore has not been created."
			render "new"
		end
	end

	def show
	end

	def edit
	end

	def update
		if @datastore.update(datastore_params)
			flash[:notice] = "Datastore has been updated."
			redirect_to @datastore
		else
			flash[:alert] = "Datastore has not been updated."
			render "edit"
		end
	end

	def destroy
		@datastore.destroy
		
		flash[:notice] = "Datastore has been destroyed."
		
		redirect_to datastores_path
	end


	private
	def datastore_params
		params.require(:datastore).permit(:name, :mediatype)
	end

	def set_datastore
		@datastore = Datastore.find(params[:id])
		rescue ActiveRecord::RecordNotFound
		flash[:alert] = "The datastore you were looking for could not be found."
		redirect_to datastores_path
	end

end
