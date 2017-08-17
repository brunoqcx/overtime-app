FactoryGirl.define do
  factory :post do
    date Date.today
    rationale "blah"
    overtime_request 2.5
    user
  end

  factory :second_post, class: 'Post' do
    date Date.yesterday
    rationale "blah blah"
    overtime_request 1.5
    user
  end

  factory :post_from_other_user, class: 'Post' do
    date Date.yesterday
    rationale "blah blah non authorized"
    non_authorized_user
  end
end
