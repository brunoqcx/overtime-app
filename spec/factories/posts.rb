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
end
