module TokenAuthenticatable
  class TokenStrategy < Devise::Strategies::Authenticatable
    def valid?
      request.headers['X-Auth-Token'].present?
    end

    def authenticate!
      #_klass = mapping.to
      if request.headers['X-Auth-Token'].present?
        _user = mapping.to.find_by_auth_token(request.headers['X-Auth-Token'])
        _user.nil? ? fail!(_user) : success!(_user)
      end
    end
  end
end

Warden::Strategies.add :token_authenticatable, TokenAuthenticatable::TokenStrategy
Devise.add_module :token_authenticatable, :strategy => true