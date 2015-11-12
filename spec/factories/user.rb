FactoryGirl.define do
  factory :user do
    name 'user'
    email 'tests@test.com'
    encrypted_password '$2a$10$VSkUDEbcYxo5FkIHNLTkY.VV8sbotpnP2xmcA5uEru2woU5ybGDM6'
    auth_token '7337908e6f89455493227edecdb1469e'
    created_at Time.now
    updated_at Time.now
  end
end