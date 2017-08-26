require 'rails_helper'

describe 'Audit Log Feature' do
  before do
    user = FactoryGirl.create(:admin_user)
    login_as(user, :scope => :user)
    FactoryGirl.create(:audit_log)
    visit audit_logs_path
  end

  describe 'index' do
    it 'has a index that can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'renders audit log contet' do
      expect(page).to have_content(/Bruno/)
    end

    it 'cannot be accessed by non admins' do
      logout(:user)
      admin_user = FactoryGirl.create(:user)
      login_as(admin_user, :scope => :user)

      visit audit_logs_path

      expect(current_path).to eq(root_path)
    end
  end
end
