module API
  module Version1
    module Helpers
      include Devise::Controllers::SignInOut

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
        _user = User.find_by_auth_token(request.headers['X-Auth-Token']) if request.headers['X-Auth-Token'].present?
        raise UnauthorizedError, 'Invalid API public token' if _user.nil?
        @current_user ||= _user
      end

      def user_by_email!
        warden.authenticate!(:email_authenticatable, :scope => :user)
        current_user.auth_token
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

      def user_sign_out(token)
        _user = user_by_email!
        sign_out(:user)
      end
    end
  end
end