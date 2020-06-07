require 'rails_helper'
describe User do
  describe '#create' do
    it "必須項目のtextを入力していれば、登録できること" do
      post = build(:post)
      post.valid?
      expect(post).to be_valid
    end

    it "textがない場合は、登録できないこと" do
      post = build(:post, text: "")
      post.valid?
      expect(post.errors[:text]).to include("を入力してください")
    end

    it "textが300文字以内であれば登録できること" do
      post = build(:post, text: "これなら登録できると")
      post.valid?
      expect(post).to be_valid
    end

    it "textが301文字以上の場合、登録できないこと" do
      post = build(:post, text: "テストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテスト")
      post.valid?
      expect(post.errors[:text]).to include("は300文字以内で入力してください")
    end
  end
end