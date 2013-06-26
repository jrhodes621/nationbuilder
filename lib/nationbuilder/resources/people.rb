module NationBuilder
	class People < NationBuilder::Resources
		attr_accessor :id, :first_name, :last_name, :email, :phone, :mobile, :home_address, :tags, :sex
		
		def initialize(person)
			person.each { |k,v| instance_variable_set("@#{k}", v) }
		end

		def update!(person={})
			self.class.update(@id, person)
		end

		def destroy
			self.class.destroy(@id)
		end

		def register
			self.class.get_resource("people/#{@id}/register")['status'] == 'success'
		end

		def self.all
			get_resource('people')['results'].collect { |hash| new(hash)  }
		end

		def self.find(id)
			if person = get_resource("people/#{id}")['person']
				return new(person)
			end
		end

		def self.create(person={})
			if person = create_resource('people', :person => person)['person']
				return new(person)
			end
		end

		def self.update(person_id, person)
			if person = update_resource("people/#{person_id}", :person => person)['person']
				return new(person)
			end
		end

		def self.update_or_create(person={})
			if person = update_resource('people/push', :person => person)['person']
				return new(person)
			end
		end

		def self.destroy(person_id)
			destroy_resource("people/#{person_id}")
		end
			
		def self.match(match_params={}, req_params={})
			if person = get_resource('people/match', match_params.merge(req_params))['person']
				return new(person)
			end
		end
	end
end