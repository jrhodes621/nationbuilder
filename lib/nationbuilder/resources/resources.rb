require "json"

module NationBuilder
	class Resources
		def self.get_resource(resource, params={})
			raise NotConfigured if NationBuilder.api.nil?
			response = NationBuilder.api.get(resource_url(resource), merge_headers!(params))

			JSON.parse(response.body)
		end

		def self.create_resource(resource, resource_params={})
			raise NotConfigured if NationBuilder.api.nil?
			response = NationBuilder.api.post(resource_url(resource), merge_headers!(resource_params))

			JSON.parse(response.body)
		end

		def self.destroy_resource(resource, resource_params={})
			raise NotConfigured if NationBuilder.api.nil?
			response = NationBuilder.api.delete(resource_url(resource), merge_headers!(resource_params))

			JSON.parse(response.body)
		end

		def self.update_resource(resource, resource_params={})
			raise NotConfigured if NationBuilder.api.nil?
			response = NationBuilder.api.put(resource_url(resource), merge_headers!(resource_params))

			JSON.parse(response.body)
		end

		private 

		def self.merge_headers!(params)
			{
				:headers => { 'Accept' => 'application/json', 'Content-Type' => 'application/json' },
				:params => params
			}
		end

		def self.resource_url(resource)
			"/api/v1/#{resource}"
		end
	end
end