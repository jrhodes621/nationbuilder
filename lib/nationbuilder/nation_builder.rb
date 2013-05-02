require 'oauth2'

module NationBuilder
	class << self
		attr_reader :access_token, :client, :api

		def configure(opts={})
			@opts = opts
			@access_token = opts[:access_token]
			@client = OAuth2::Client.new(opts[:client_id], opts[:client_secret],
		      :site => "https://#{opts[:nation_name]}.nationbuilder.com"
		    )
			
			@api = OAuth2::AccessToken.new @client, @access_token
		end
	end
end