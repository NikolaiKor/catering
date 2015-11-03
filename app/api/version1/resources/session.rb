require "grape"
module API
  module Version1
    class Session < ::Grape::API
      version 'v1', using: :path

      resource :session do
        desc 'Sign in by a-mail anp password ang receive token'
        post '/' do
          _token = user_by_email!
          throw Grape::Exceptions::ValidationErrors if _token.nil?
          Rack::Response.new({token: _token}.to_json, 200, {'Content-Type' => 'application/json'})
        end

        desc 'Sign out ang destroy token'
        delete '/sign_out' do
          Rack::Response.new({logged_out: user_sign_out(@params[:token])}.to_json, 200, {'Content-Type' => 'application/json'})
        end
      end
    end
  end
end
