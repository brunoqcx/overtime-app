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

  describe 'new' do
    it 'has a link from home' do
    visit root_path

    click_link ('new_post_from_nav')
    expect(page.status_code).to eq(200)
    end
  end

  describe 'delete' do
    it 'can be deleted' do
    @post = FactoryGirl.create(:post)
    visit posts_path

    click_link ("delete_post_#{@post.id}_from_index")
    expect(page.status_code).to eq(200)
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

  describe 'edit' do
    before do
      @post = FactoryGirl.create(:post)
    end

    it 'can be reached by clicking edit on index page' do
      visit posts_path

      click_link ("edit_#{@post.id}")

      expect(page.status_code).to eq(200)
    end

    it 'can be edited' do
      visit edit_post_path(@post)

      fill_in 'post[date]', with: Date.tomorrow
      fill_in 'post[rationale]', with: 'edited post'
      click_on 'Save'

      expect(page.status_code).to eq(200)
      expect(page).to have_text('edited post')
    end
  end
end
