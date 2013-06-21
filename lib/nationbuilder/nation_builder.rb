require 'oauth2'

module NationBuilder
	class NotConfigured < Exception; end 
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

		def authorize_url
			raise NotConfigured unless @client
			
			@client.auth_code.authorize_url(:redirect_uri => @opts[:redirect_uri])
		end

		def set_token_from_code!(code)
			raise NotConfigured unless @client

			@api = @client.auth_code.get_token(code, :redirect_uri => @opts[:redirect_uri])
			@access_token = @api.token

			return @access_token
		end
	end
end