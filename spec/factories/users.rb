FactoryGirl.define do
  sequence :email do |n|
    "test#{n}@email.com"
  end

  factory :user do
    first_name 'Bruno'
    last_name 'Tavares'
    email { generate :email }
    password 'asdfasdf'
    password_confirmation 'asdfasdf'
  end

  factory :admin_user, class: 'AdminUser' do
    first_name  'Admin'
    last_name 'User'
    email 'admin@test.com'
    password 'asdfasdf'
    password_confirmation 'asdfasdf'
  end
end
