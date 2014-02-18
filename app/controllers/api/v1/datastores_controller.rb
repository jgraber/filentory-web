class Api::V1::DatastoresController < Api::V1::BaseController

	def index
		respond_with(Datastore.all)
	end
	
	def show
		@datastore = Datastore.includes(:locations).find(params[:id])

		respond_with(
			:datastore => @datastore.as_json,
			:locations => @datastore.locations.as_json)
	end

	def create
		if params[:data]
			datastore = create_datastore_from_cli(params)
		else
			datastore = Datastore.new(datastore_params)
		end

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
			loc.save
		end
		
		#json["files"].each do |f|
		#	puts f#["name"]
			#file = JSON.parse(f)
			#puts file["name"]
		#end
	end
end

