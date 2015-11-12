require 'rspec'
require_relative '../rails_helper'
require_relative '../../app/admin/user'

describe API::Version1::Engine, :type => :request do
  include Rack::Test::Methods

  before(:all) do
    FactoryGirl.create(:user, email: EMAIL)
    FactoryGirl.create(:category)
    FactoryGirl.create(:daily_menu)
    FactoryGirl.create(:dish, title:'Tea', price:5)
    FactoryGirl.create(:dish)
    FactoryGirl.create(:dish, title:'Coffee', price:15)
    @token = User.where(:email => EMAIL).take.auth_token
  end

  describe 'GET /api/v1/daily_menus' do
    it 'get all daily menus' do
      header 'X-Auth-Token', @token
      get 'api/v1/daily_menus/'
      expect(last_response.body).to have_node(:max_total).with(55)
    end

    it 'get daily menu by id' do
      header 'X-Auth-Token', @token
      get 'api/v1/daily_menus/1'
      expect(last_response.body).to have_node(:max_total).with(55)
    end

    it 'get dishes from daily menu by daily menu id' do
      header 'X-Auth-Token', @token
      get 'api/v1/daily_menus/1/dishes'
      expect(last_response.body).to have_node(:title).with('Tea')
      expect(last_response.body).to have_node(:title).with('Soup')
      expect(last_response.body).to have_node(:title).with('Coffee')
    end
  end
end