class LocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_datastore
  before_action :set_location, only: [:show, :edit, :update, :destroy]


  def new
    @location = @datastore.locations.build
  end

  def create
    @location = @datastore.locations.build(location_params)
    update_datafile         
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
    @location.attributes=location_params
    update_datafile
    if @location.save
      flash[:notice] = "Location has been updated."
      redirect_to [@datastore, @location]
    else
      flash[:alert] = "Location has not been updated."
      render action: "edit"
    end
  end

  def destroy
    @location.destroy
    flash[:notice] = "Location has been deleted."
    redirect_to @datastore
  end

  private
  def set_datastore
    @datastore = Datastore.find(params[:datastore_id])
  end

  def set_location
    @location = @datastore.locations.find(params[:id])
  end

  def location_params
    params.require(:location).permit(:name, :path, :last_modified, :checksum, :size)
  end

  def update_datafile
    before_datafile = @location.datafile
    return if before_datafile.nil? and @location.checksum.empty?

    before_checksum = nil
    before_checksum = before_datafile.checksum unless before_datafile.nil?

    if !before_datafile.nil? and @location.checksum.empty? 
      @location.datafile = nil
    else
      datafile = get_or_create_datafile(@location)
      @location.datafile = datafile unless !before_datafile.nil? || before_checksum == @location.checksum
    end
  end

  def get_or_create_datafile(location)
    datafile = Datafile.find_or_create_by(checksum: location.checksum)
    if not datafile.persisted?
      datafile.size = location.size
      datafile.name = location.name
      datafile.locations_count = 0
    end
    datafile
  end

end
