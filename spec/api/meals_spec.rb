require 'rspec'
require_relative '../rails_helper'
require_relative '../../app/admin/user'

describe API::Version1::Engine, :type => :request do
  include Rack::Test::Methods

  before(:all) do
    FactoryGirl.create(:user, email: EMAIL)
    FactoryGirl.create(:category, dishes_count: 2)
    FactoryGirl.create(:dish)
    FactoryGirl.create(:business_lunch)
    FactoryGirl.create(:dish, title:'Tea', price:5)
    @token = User.where(:email => EMAIL).take.auth_token
  end

  describe 'GET /api/v1/meals' do
    it 'get meals in group by group id' do
      header 'X-Auth-Token', @token
      get 'api/v1/meals/group?group=1'
      expect(last_response.body).to have_node(:title).with('Soup')
      expect(last_response.body).to have_node(:title).with('Tea')
      expect(last_response.body).to have_node(:title).with('Student lunch')
    end

    it 'get dish by id and meal type' do
      header 'X-Auth-Token', @token
      get 'api/v1/meals/dish/1'
      expect(last_response.body).to have_node(:title).with('Soup')
    end

    it 'get business lunch by id and meal type' do
      header 'X-Auth-Token', @token
      get 'api/v1/meals/businesslunch/1'
      expect(last_response.body).to have_node(:title).with('Student lunch')
    end
  end
end