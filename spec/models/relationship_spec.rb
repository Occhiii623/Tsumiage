require 'rails_helper'
describe Relationship do

  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  let(:active) { user.relationships.build(follow_id: other_user.id) }
  subject { active }

  # リレーションシップが有効であること
  it { should be_valid }

  # follow/followedメソッド
  describe "follower/followedメソッド" do
    it { should respond_to(:user) }
    it { should respond_to(:follow) }

    it "followメソッドは、フォローしているユーザを返すこと" do
      expect(active.user).to eq user 
    end

    it "followedメソッドは、フォローされているユーザを返すこと" do
      expect(active.follow).to eq other_user 
    end
  end

  
  describe "validations" do
    describe "presence" do
      it { is_expected.to validate_presence_of(:user_id) }
      it { is_expected.to validate_presence_of(:follow_id) }
    end
  end
end