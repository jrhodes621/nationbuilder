module NationBuilder
	class People < NationBuilder::Resources
		attr_accessor :id, :first_name, :last_name, :email, :phone, :mobile, :home_address
		
		def initialize(person)
			person.each { |k,v| instance_variable_set("@#{k}", v) }
		end

		def self.all
			get_resource('people')['results'].collect { |hash| new(hash)  }
		end

		def self.create(person={})
			if person = create_resource('people', :person => person)['person']
				return new(person)
			end
		end
			
		def self.match(match_params={}, req_params={})
			if person = get_resource('people/match', match_params.merge(req_params))['person']
				return new(person)
			end
		end
	end
end