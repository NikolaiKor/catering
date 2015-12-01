require 'rspec'
require_relative '../rails_helper'
require_relative '../../app/admin/user'

describe API::Version1::Engine, :type => :request do
  include Rack::Test::Methods

  before(:all) do
    FactoryGirl.create(:user, email: EMAIL)
    FactoryGirl.create(:sprint)
    FactoryGirl.create(:sprint, state: 0, title:'Pending sprint')
    FactoryGirl.create(:sprint, state: 2, title:'Ended sprint')
    FactoryGirl.create(:daily_menu)
    FactoryGirl.create(:category)
    FactoryGirl.create(:dish)
    @token = User.where(:email => EMAIL).take.auth_token
  end
  # need test get sprint with state 0
  # describe 'GET /api/v1/sprints' do
  #   it 'get sprint by id' do
  #     header 'X-Auth-Token', @token
  #     get 'api/v1/sprints'
  #     expect(last_response.body).to have_node(:title).with('Active Sprint')
  #     expect(last_response.body).to have_node(:title).with('Ended sprint')
  #   end
  # end
end