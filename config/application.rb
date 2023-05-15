require_relative "boot"

require "rails/all"
#require 'net/http'
#require 'jwt'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true


    #source = 'https://local.fusionauth.io/.well-known/jwks.json' 
    #resp = Net::HTTP.get_response(URI.parse(source))
    #data = resp.body
    #jwks_hash = JSON.parse(data)

    #jwks = JWT::JWK::Set.new(jwks_hash)
    #jwks.select! { |key| key[:use] == 'sig' } # Signing Keys only 
    #
    #jwt_auth_args = { 
      #secret: nil,
      #options: { 
        #cookie_name: 'cook', # documented that it goes in args hash, but https://github.com/mindfulchefuk/rack-jwt/blob/master/lib/rack/jwt/auth.rb#L51 indicates otherwise
        #iss: 'acme.com', 
        #verify_iss: true, 
        #aud: '85a03867-dccf-4882-adde-1a79aeec50df', 
        #verify_aud: true, 
        #verify_iat: true, 
        #verify_expiration: true, 
        #required_claims: ['applicationId'],
        #jwks: jwks,
        #algorithm: 'RS256'
      #}
    #}
    #config.middleware.use Rack::JWT::Auth, jwt_auth_args
  end
end
