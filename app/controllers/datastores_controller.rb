class DatastoresController < ApplicationController
	def index
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
			# nothing, yet
		end
	end

	def show
		@datastore = Datastore.find(params[:id])
	end


private
def datastore_params
	params.require(:datastore).permit(:name, :mediatype)
end
end
