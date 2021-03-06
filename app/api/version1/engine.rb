#require 'action_dispatch/middleware/remote_ip.rb'

module API
  module Version1
    autoload :Helpers,    'version1/resources/helpers'
    autoload :Sprints,    'version1/resources/sprints'
    autoload :Meals,     'version1/resources/meals'
    autoload :DailyMenus, 'version1/resources/daily_menus'
    autoload :DailyRations, 'version1/resources/daily_rations'
    autoload :Session, 'version1/resources/session'
    autoload :Categories, 'version1/resources/categories'

    class Engine < ::Grape::API
      format :json
      default_format :json
      default_error_formatter :json
      content_type :json, 'application/json'
      version 'v1', using: :path


      helpers API::Version1::Helpers

      mount API::Version1::Sprints
      mount API::Version1::DailyMenus
      mount API::Version1::Meals
      mount API::Version1::Session
      mount API::Version1::DailyRations
      mount API::Version1::Categories

      add_swagger_documentation base_path: "/api", hide_documentation_path: true, api_version: "v1"

      get "/" do
        # option_request_check
        {:timenow => Time.zone.now.to_i}
      end
    end
  end
end