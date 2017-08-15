FactoryGirl.define do
  factory :post do
    date Date.today
    rationale "blah"
    user
  end

  factory :second_post, class: 'Post' do
    date Date.yesterday
    rationale "blah blah"
    user
  end

  factory :post_from_other_user, class: 'Post' do
    date Date.yesterday
    rationale "blah blah non authorized"
    non_authorized_user
  end
end
