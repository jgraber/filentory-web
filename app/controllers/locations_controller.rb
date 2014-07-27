class LocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_datastore
  before_action :set_location, only: [:show, :edit, :update, :destroy]


  def new
    @location = @datastore.locations.build
  end

  def create
    @location = @datastore.locations.build(location_params)
    set_datafile unless @location.checksum.empty?
              
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

  def set_datafile
    #puts "Location: size: #{@location.size}, check: #{@location.checksum}"
    datafile = Datafile.find_or_create_by(checksum: @location.checksum)
    #puts "Datafile for location: #{datafile.checksum}, size: #{datafile.size}, id: #{datafile.id}, name: #{datafile.name}"
    
    if not datafile.persisted?
      datafile.size = @location.size
      datafile.name = @location.name
      datafile.save!
      #puts "datafile id: #{datafile.id}"
    end

    
    @location.datafile = datafile
    @location.save
    datafile.save
  end
end
