class MetadataController < ApplicationController
  before_action :authenticate_user!
  before_action :set_datafile
  before_action :set_metadata, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
    @metadata = @datafile.metadata.build
  end

    def create
    @metadata = @datafile.metadata.build(metadata_params)
    if @metadata.save
      flash[:notice] = "Metadata has been created."
      redirect_to [@datafile, @metadata]
    else
      flash[:alert] = "Metadata has not been created."
      render "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @metadata.update(metadata_params)
      flash[:notice] = "Metadata has been updated."
      redirect_to [@datafile, @metadata]
    else
      flash[:alert] = "Metadata has not been updated."
      render action: "edit"
    end
  end

  def destroy
    @metadata.destroy
    flash[:notice] = "Metadata has been deleted."
    redirect_to @datafile
  end

  private
  def set_datafile
    @datafile = Datafile.find(params[:datafile_id])
  end

  def set_metadata
    @metadata = @datafile.metadata.find(params[:id])
  end

  def metadata_params
    params.require(:metadata).permit(:key, :value)
  end
end