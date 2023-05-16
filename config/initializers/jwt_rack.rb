require 'net/http'
require 'jwt'

source = 'http://localhost:9011/.well-known/jwks.json'
resp = Net::HTTP.get_response(URI.parse(source))
data = resp.body
jwks_hash = JSON.parse(data)
jwks = JWT::JWK::Set.new(jwks_hash)
jwks.select! { |key| key[:use] == 'sig' } # Signing Keys only

jwt_auth_args = {
      secret: nil,
      options: {
        cookie_name: 'app.at',
        iss: 'acme.com',
        verify_iss: true,
        aud: 'e9fdb985-9173-4e01-9d73-ac2d60d1dc8e',
        verify_aud: true,
        verify_iat: true,
        verify_expiration: true,
        required_claims: ['applicationId'],
        jwks: jwks,
        algorithm: 'RS256'
      }
}

Rails.application.config.middleware.use Rack::JWT::Auth, jwt_auth_args
