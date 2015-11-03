module TokenAuthenticatable
  class TokenStrategy < Devise::Strategies::Authenticatable
    def valid?
      !request.headers['X-Auth-Token'].nil?
    end

    def authenticate!
      _token = request.headers['X-Auth-Token']
      _user = mapping.to.find_auth_token(_token)
      raise UnauthorizedError, 'Invalid auth token' if _user.nil? || _user.auth_token != _token
      success! _user
    end
  end
end

Warden::Strategies.add :token_authenticatable, TokenAuthenticatable::TokenStrategy
Devise.add_module :token_authenticatable, :strategy => true