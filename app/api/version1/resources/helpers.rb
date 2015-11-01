module API
  module Version1
    module Helpers
      def warden
        @warden ||= request.env["warden"]
      end

      def current_user
        @current_user ||= warden.user(:user)
      end

      def user_logged_in?
        warden.authenticated?(:account)
      end

      def user_by_token!
        env['devise.skip_trackable'] = true
        warden.authenticate!(:token_authenticatable, :scope => :user)
      end

      def user_by_email!
        warden.authenticate!(:database_authenticatable, :scope => :user)
        auth_token = nil
        if warden.authenticated?(:user)
          auth_token = SecureRandom.uuid.gsub(/\-/, '')
          current_user.auth_token = auth_token
          @current_user.save
        end
        auth_token
      end

      def client_ip
        env["action_dispatch.remote_ip"].to_s
      end

      def price(type, id, quantity)
        meal = case type
                 when 'Dish' then
                   Dish.find(id)
                 when 'BusinessLunch' then
                   BusinessLunch.find(id)
               end
        meal.price * quantity
      end
    end
  end
end