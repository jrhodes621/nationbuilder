require 'oauth2'
require_relative "nationbuilder/resources/resources"
require_relative "nationbuilder/resources/people"

module NationBuilder
	class NotConfigured < Exception; end 
	class << self
		attr_reader :access_token, :client, :api, :nation_name, :redirect_uri, :opts

		def configure(opts={})
			@access_token = opts[:access_token]
			@nation_name = opts[:nation_name]
			
			@redirect_uri ||= opts[:redirect_uri]
			@client_id ||= opts[:client_id]
			@client_secret ||= opts[:client_secret]
			@opts = opts
			
			@client = OAuth2::Client.new(@client_id, @client_secret,
		      :site => "https://#{@nation_name}.nationbuilder.com",
		      :ssl => { :verify => OpenSSL::SSL::VERIFY_PEER, 
		      :ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'
		    )
			
			@api = OAuth2::AccessToken.new @client, @access_token, @opts
		end

		def access_token=(token)
			@access_token = token

			configure access_token: token
		end

		def authorize_url
			raise NotConfigured unless @client
			
			@client.auth_code.authorize_url :redirect_uri => @redirect_uri 
		end

		def people
			People
		end

		def get_token_from_code!(code)
			raise NotConfigured unless @client

			@api = @client.auth_code.get_token code, :redirect_uri => @redirect_uri

			return api
		end
	end
end