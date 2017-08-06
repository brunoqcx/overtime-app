require 'rails_helper'

describe 'navigate' do
  before do
    user = FactoryGirl.create(:user)
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
      post = FactoryGirl.create(:post)
      second_post = FactoryGirl.create(:second_post)

      visit posts_path

      expect(page).to have_text(post.rationale)
      expect(page).to have_text(second_post.rationale)
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
