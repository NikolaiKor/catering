require "grape"
module API
  module Version1
    class DailyRations < ::Grape::API
      version 'v1', using: :path

      resource :daily_rations do
        before do
          user_by_token!
        end

        desc "User's daly rations by id" do
          headers 'X-Auth-Token' => {
              description: 'Authentification token',
              required: true
          }
        end
        params do
          requires :id, type: Integer, desc: 'group id'
        end
        get '/:id' do
          _result = Hash.new
          _dishes = []
          _start = nil
          _rations = DailyRation.where(person_id: current_user.id, sprint_id: @params[:id])
                         .includes(:meal).includes(:sprint).all
          _rations.each do |ration|
            _sprint = ration.sprint
            _day_number = ration.daily_menu.day_number
            _start = _sprint.started_at
            _result[:start] = _start.strftime('%d.%m.%y')
            _result[:finish] = _sprint.finished_at.strftime('%d.%m.%y')
            _dishes[_day_number] = [] if _dishes[_day_number].nil?
            _dishes[_day_number] << {type: ration.meal_type, name: ration.meal.title,
                                     quantity: ration.quantity}
          end
          _days = []
          _dishes.each_index do |index|
            next if _dishes[index].nil?
            _date = _start+(index-1)
            _days << {day: _date.strftime('%A'),
                      date: _date.strftime('%d.%m.%y'), meals: _dishes[index]}
          end
          _result[:days] = _days
          _result
        end
      end
    end
  end
end