require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Creation' do
    before do
      @post = FactoryGirl.build_stubbed(:post)
      @second_post = FactoryGirl.create(:second_post)
    end
    it 'can be created' do
      expect(@post).to be_valid
    end

    it 'cannot be created without date and rationale' do
      @post.date = nil
      @post.rationale = nil

      expect(@post).to_not be_valid
    end

    it 'has a overtime request greather than 0' do
      @second_post.overtime_request = 0.0
      expect(@second_post).to_not be_valid
    end
  end
end
