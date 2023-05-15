require 'net/http'
require 'jwt'

source = 'https://local.fusionauth.io/.well-known/jwks.json'
resp = Net::HTTP.get_response(URI.parse(source))
data = resp.body
jwks_hash = JSON.parse(data)
jwks = JWT::JWK::Set.new(jwks_hash)
jwks.select! { |key| key[:use] == 'sig' } # Signing Keys only

jwt_auth_args = {
      secret: nil,
      options: {
        cookie_name: 'cook', # documented that it goes in args hash, but https://github.com/mindfulchefuk/rack-jwt/blob/master/lib/rack/jwt/auth.rb#L51 indicates otherwise
        iss: 'acme.com',
        verify_iss: true,
        aud: '85a03867-dccf-4882-adde-1a79aeec50df',
        verify_aud: true,
        verify_iat: true,
        verify_expiration: true,
        required_claims: ['applicationId'],
        jwks: jwks,
        algorithm: 'RS256'
      }
}

Rails.application.config.middleware.use Rack::JWT::Auth, jwt_auth_args
