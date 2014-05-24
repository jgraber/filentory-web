class DatafilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_datafile, only: [:show, :edit, :update, :destroy]
  
  def index
    @datafiles = Datafile.all.page params[:page]
  end

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

  def edit
  end

  def update
    if @datafile.update(datafile_params)
      flash[:notice] = "Datafile has been updated."
      redirect_to @datafile
    else
      flash[:alert] = "Datafile has not been updated."
      render "edit"
    end
  end

  def destroy
    @datafile.destroy
    
    flash[:notice] = "Datafile has been destroyed."
    
    redirect_to datafiles_path
  end

  private
  def datafile_params
    params.require(:datafile).permit(:name, :size, :checksum)
  end

  def set_datafile
    @datafile = Datafile.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The datafile you were looking for could not be found."
    redirect_to datafiles_path
  end
end
