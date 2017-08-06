FactoryGirl.define do
  factory :user do
    first_name  'Bruno'
    last_name 'Tavares'
    email 'bruno@test.com'
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
