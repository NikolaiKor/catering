#require 'action_dispatch/middleware/remote_ip.rb'

module API
  module Version1
    autoload :Helpers,    'version1/resources/helpers'
    autoload :Sprints,    'version1/resources/sprints'
    autoload :Dishes,     'version1/resources/dishes'
    autoload :DailyMenus, 'version1/resources/daily_menus'

    class Engine < ::Grape::API
      format :json
      default_format :json
      default_error_formatter :json
      content_type :json, 'application/json'
      version 'v1', using: :path


      helpers API::Version1::Helpers

      mount API::Version1::Sprints
      mount API::Version1::DailyMenus
      mount API::Version1::Dishes

      add_swagger_documentation base_path: "/api", hide_documentation_path: true, api_version: "v1"

      get "/" do
        {:timenow => Time.zone.now.to_i}
      end

      # get '/session' do
      #   print 'PASSWORD!!!!!!!!!!!!!: '+ params[:user][:password]
      #   _token = user_by_email!
      #   throw Grape::Exceptions::ValidationErrors if _token.nil?
      #   Rack::Response.new({token: _token}.to_json, 200, {'Content-Type' => 'application/json'})
      # end

      get '/token' do
        _user = user_by_token!
        Rack::Response.new({user: current_user}.to_json, 200, {'Content-Type' => 'application/json'})
      end
    end
  end
end