class Api::V1::DatastoresController < Api::V1::BaseController

  def index
    respond_with(Datastore.all)
  end
  
  def show
    @datastore = Datastore.includes(:locations).find(params[:id])

    respond_with(
      :datastore => @datastore.as_json,
      :locations => @datastore.locations.as_json,
      :files => get_referenced_files(@datastore))
  end

  def create
    #puts params
    if params[:data]
      datastore = create_datastore_from_cli(params)
    else
      datastore = Datastore.new(datastore_params)
    end
#datastore = create_datastore_from_cli(params)
    if datastore.save
      respond_with(datastore, :location => api_v1_datastore_path(datastore))
    else
      respond_with(datastore)
    end
  end

  private
  def datastore_params
    params.require(:datastore).permit(:name, :mediatype)
  end

  def create_datastore_from_cli(params)
    json = JSON.parse(params[:data])

    datastore = Datastore.new
    set_datastore_variables(datastore, json)
    add_locations(datastore, json)

    datastore
  end

  def set_datastore_variables(datastore, json)
    datastore.name = json["name"]
    datastore.mediatype = json["mediatype"]
    datastore.save
  end

  def add_locations(datastore, json)
    json["files"][0].each do |f| 
      loc = datastore.locations.build
      loc.name = f["name"]
      loc.path = f["path"]
      loc.last_modified = f["last_modified"]
      find_or_create_datafile(loc, f)
      loc.save
    end
  end

  def find_or_create_datafile(loc, file)
    df = Datafile.find_or_create_by(checksum: file["checksum"])

    if not df.persisted?
      df.size = file["size"]
      df.name = file["name"]
      df.save!
    end

    add_or_update_metadata(df, file["metadata"])
    
    loc.datafile = df
  end

  def add_or_update_metadata(file, metadata)
    if not metadata.nil?
      metadata.each do |key, value| 
        meta = file.metadata.find_or_create_by(key: key)
        meta.value = value
        meta.save!
      end
    end
  end
  
  def get_referenced_files(datastore)
    result = Array.new
    datastore.locations.each do |loc|
      file = Array.new
      file << loc.datafile
      loc.datafile.metadata.each {|m| file << m}


      result << file
    end
    result.to_json
  end
end

