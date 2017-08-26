require 'rails_helper'

RSpec.describe AuditLog, type: :model do
  before do
    @audit_log = FactoryGirl.create(:audit_log)
  end

  describe 'creation' do
    it 'can be created' do
      expect(@audit_log).to be_valid
    end
  end

  describe 'validations' do
    before do
      @audit_log_valid = FactoryGirl.build_stubbed(:audit_log)
    end

    it 'should be required to have a user association' do
      @audit_log_valid.user_id = nil

      expect(@audit_log_valid).to_not be_valid
    end

    it 'should always have a status' do
      @audit_log_valid.status = nil

      expect(@audit_log_valid).to_not be_valid
    end

    it 'should require to have a start date' do
      @audit_log_valid.start_date = nil

      expect(@audit_log_valid).to_not be_valid
    end

    it 'should have a start date equals to 6 days prior' do
      new_audit_log = AuditLog.create(user_id: User.last.id, status: 0, start_date:())

      expect(new_audit_log.start_date).to eq(Date.today - 6.days)
    end
  end
end
