require 'rails_helper'

describe 'navigate' do
  before do
    user = User.create(email: 'post_spec_feature@test.com', password: 'asdfasdf', password_confirmation: 'asdfasdf', first_name: 'bruno', last_name: 'tavares')
    login_as(user, scope: :user)
    visit posts_path
  end

  describe 'index' do
    it 'can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'has a title of posts' do
      expect(page).to have_content(/Posts/)
    end

    it 'has a list of posts' do
      post1 = Post.create(date: Date.today, rationale: "blah", user: User.first)
      post1 = Post.create(date: Date.today, rationale: "blahblah", user: User.first)
      visit posts_path
      expect(page).to have_content(/blah|blahblah/)
    end
  end

  describe 'creation' do
    before do
      visit new_post_path
    end

    it 'has a new form that can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'can be created from the new form page' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "Novo Post"
      click_on 'Save'

      expect(page).to have_content("Novo Post")
    end

    it 'will have a user associated it' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'User_Association'
      click_on 'Save'

      expect(User.last.posts.last.rationale).to eq("User_Association")
    end
  end
end
