module EmailAuthenticatable
  class EmailStrategy < Devise::Strategies::Authenticatable
    def valid?
      user_data = params.fetch('user', {})
      user_data && (!(user_data['email'].blank? || user_data['password'].blank?))
    end

    def authenticate!
      user_data = params.fetch("user", {})
      _user = mapping.to.find_by_email(user_data['email'])
      raise ::API::UnauthorizedError, 'Invalid e-mail or password' if _user.nil? || _user.password != params['user']['password']
      generate_auth_token _user
      success! _user
    end

    def generate_auth_token(_user)
      auth_token = SecureRandom.uuid.gsub(/\-/, '')
      _user.auth_token = auth_token
      _user.save
    end
  end

  Warden::Manager.before_logout do |user, auth, opts|
    unless auth.user(:user).nil?
      _user = auth.user(:user)
      _user.auth_token = ''
      _user.save!
    end
  end
end

Warden::Strategies.add :email_authenticatable, EmailAuthenticatable::EmailStrategy
Devise.add_module :email_authenticatable, :strategy => true