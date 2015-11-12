require 'rspec'
require_relative '../rails_helper'
require_relative '../../app/admin/user'

describe API::Version1::Engine, :type => :request do
  include Rack::Test::Methods

  token=''
  password=''
  EMAIL = 'test@test.com.ua'

  before(:all) do
    generated_password = Devise.friendly_token.first(8)
    _user = User.create!(email: EMAIL, password: generated_password)
    _user.save!
    password = generated_password
  end

  describe 'GET /api/v1/session' do
    it 'log in and get token' do
      post 'api/v1/session', {user: {email: EMAIL, password: password}}
      expect(last_response.status).to create_resource
      expect(last_response.body).to have_node(:token)
      expect(last_response.body).to have_node(:email).with(EMAIL)
      token = JSON.parse(last_response.body)['token']
    end

    it 'log out session' do
      header 'X-Auth-Token', token+'z'
      delete 'api/v1/session'
      expect(last_response.status).to be_unauthorized
    end

    it 'log out session' do
      header 'X-Auth-Token', token
      delete 'api/v1/session'
      expect(last_response.body).to have_node(:logged_out).with(true)
    end
  end
end