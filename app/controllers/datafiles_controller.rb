class DatafilesController < ApplicationController
	before_action :set_datafile, only: [:show, :edit, :update, :destroy]

	def new
		@datafile = Datafile.new
	end

	def create
		@datafile = Datafile.new(datafile_params)
		if @datafile.save
			flash[:notice] = "Datafile has been created."
			redirect_to @datafile 
		else
			flash[:alert] = "Datafile has not been created."
			render"new"
		end
	end


	def show
	end

	private
	def datafile_params
		params.require(:datafile).permit(:name, :size, :checksum)
	end

	def set_datafile
		@datafile = Datafile.find(params[:id])
		rescue ActiveRecord::RecordNotFound
		flash[:alert] = "The datafile you were looking for could not be found."
		redirect_to datafile_path
	end
end
