module TokenAuthenticatable
  class TokenStrategy < Devise::Strategies::Authenticatable
    include API
    def valid?
      !request.headers['X-Auth-Token'].nil?
    end

    def authenticate!
      _token = request.headers['X-Auth-Token']
      _user = mapping.to.find_by_auth_token(_token)
      raise API::UnauthorizedError, 'Invalid auth token' if _user.nil? || _user.auth_token != _token
      success! _user
    end
  end
end

Warden::Strategies.add :token_authenticatable, TokenAuthenticatable::TokenStrategy
Devise.add_module :token_authenticatable, :strategy => true