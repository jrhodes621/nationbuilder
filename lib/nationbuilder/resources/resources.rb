require "json"

module NationBuilder
	class Resources
		def self.get_resource(resource, params={})
			raise NotConfigured if NationBuilder.api.nil?
			response = NationBuilder.api.get("/api/v1/#{resource}", merge_headers!(params))
			JSON.parse(response.body)
		end

		def self.create_resource(resource, resource_params)
			raise NotConfigured if 
			response = NationBuilder.api.post("/api/v1/#{resource}", merge_headers!(resource_params))
			JSON.parse(response.body)
		end

		private 

		def self.merge_headers!(params)
			{
				:headers => { 'Accept' => 'application/json', 'Content-Type' => 'application/json' },
				:params => params
			}
		end
	end
end