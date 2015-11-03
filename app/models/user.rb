class User < ActiveRecord::Base
  include BCrypt
  # Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :email_authenticatable, :registerable,
         :recoverable, :trackable, :validatable, :token_authenticatable

  def password
    @password ||= Password.new(self.encrypted_password)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.encrypted_password = @password
  end

  def valid_password?(password)
    Devise::Encryptor.compare(self.class, encrypted_password, password)
  end
end
