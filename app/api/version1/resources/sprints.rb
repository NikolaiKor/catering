require "grape"
module API
  module Version1
    class Sprints < ::Grape::API
      version 'v1', using: :path

      resource :sprints do
        desc "Returns sprints with state 'started' and 'finished'"
        get '/' do
          Sprint.where('state >0').order(:state)
        end

        desc "Returns sprints with state 'started' and 'finished'"
        get '/:sprint_id/daily_rations' do
          DailyRation.where(:sprint_id => @params[:sprint_id]).order(:daily_menu_id)
        end

        desc "Create new daily ration for sprint by sprint_id"
        params do
          requires :sprint_id, type: Integer
          requires :meal_id, type: Integer
          requires :meal_type, type: String
          requires :daily_menu_id, type: Integer
          optional :quantity, type: Integer, default: 1
        end
        post '/:sprint_id/daily_rations' do
          _hash = {sprint_id: @params[:sprint_id], meal_id: @params[:meal_id], meal_type: @params[:meal_type], daily_menu_id: @params[:daily_menu_id], quantity: @params[:quantity]}
          _hash[:person_id] = current_user.id
          _hash[:price] = price(@params[:meal_type], @params[:meal_id], @params[:quantity])
          print _hash.inspect
          _ration = DailyRation.create(_hash)
          _ration.save!
          _ration
        end
      end
    end
  end
end
