FactoryGirl.define do
  factory :post do
    date Date.today
    rationale "blah"
  end

  factory :second_post, class: 'Post' do
    date Date.yesterday
    rationale "blah blah"
  end
end
