require "grape"
module API
  module Version1
    class Session < ::Grape::API
      version 'v1', using: :path

      resource :session do
        desc 'Sign in by a-mail anp password ang receive token'
        params do
          requires :user, type: Hash do
            requires :email, allow_blank: false, type: String, desc: 'User e-mail'
            requires :password, allow_blank: false, type: String, desc: 'User password. without crypt'
          end
        end
        post '/' do
          _token = user_by_email!
          throw Grape::Exceptions::ValidationErrors if _token.nil?
          {token: _token}
        end

        desc 'Sign out ang destroy token' do
          headers 'X-Auth-Token' => {
              description: 'Authentification token',
              required: true
          }
        end
        delete '/' do
          {logged_out: user_sign_out}
        end
      end
    end
  end
end
