require 'rails_helper'

describe 'navigate' do
  let(:user) { FactoryGirl.create(:user) }

  let(:post) do
    Post.create(date: Date.today, rationale: "blah", user_id: user.id, overtime_request: 1.5)
  end

  let(:second_post) do
    Post.create(date: Date.yesterday, rationale: "blah blah", user_id: user.id, overtime_request: 1.5)
  end

  before do
    login_as(user, scope: :user)
    user.posts << [post, second_post]
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
      expect(page).to have_text(post.rationale)
      expect(page).to have_text(second_post.rationale)
    end

    it 'has a scope so that only creators can see their posts' do
      other_user = User.create(first_name: 'Non', last_name: 'Authorized', email: "nonauth@example.com", password: "asdfasdf", password_confirmation: "asdfasdf", phone: '22531177')
      post_from_other_user = Post.create(date: Date.today, rationale: "This post shouldn't be seen", user_id: other_user.id, overtime_request: 1.5)

      visit posts_path

      expect(page).to_not have_content(/This post shouldn't be seen/)
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
    old_posts_count = user.posts.count

    visit posts_path

    click_link ("delete_post_#{second_post.id}_from_index")
    expect(page.status_code).to eq(200)
    expect(old_posts_count - 1).to eq(user.posts.count)
    end
  end

  describe 'creation' do
    before do
      login_as(user, scope: :user)
      visit new_post_path
    end

    it 'has a new form that can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'can be created from the new form page' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: "Novo Post"
      fill_in 'post[overtime_request]', with: 4.5

      expect { click_on 'Save' }.to change(Post, :count).by(1)
    end

    it 'will have a user associated it' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationale]', with: 'User_Association'
      fill_in 'post[overtime_request]', with: 4.5
      click_on 'Save'

      expect(user.posts.last.rationale).to eq("User_Association")
    end
  end

  describe 'edit' do
    it 'can be edited' do
      visit edit_post_path(post)

      fill_in 'post[date]', with: Date.tomorrow
      fill_in 'post[rationale]', with: 'edited post'
      click_on 'Save'

      expect(page.status_code).to eq(200)
      expect(page).to have_text('edited post')
    end

    it 'cannot be edited by a non authorized user' do
      logout(:user)
      non_authorized_user = FactoryGirl.create(:non_authorized_user)
      login_as(non_authorized_user, :scope => :user)

      visit edit_post_path(post)

      expect(current_path).to eq(root_path)
    end
  end
end
