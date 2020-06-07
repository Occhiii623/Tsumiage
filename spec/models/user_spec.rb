require 'rails_helper'
describe User do
  describe '#create' do
    it "必須のnickname, email, password, password_confirmationの入力があれば登録できること" do
      user = build(:user, icon: "", introduction: "", URL: "")
      user.valid?
      expect(user).to be_valid
    end

    it "nicknameがない場合は、登録できないこと" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    it "emailがない場合は、登録できないこと" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "passwordがない場合は、登録できないこと" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "passwordが存在しても、password_confirmationがない場合は登録できないこと" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")
    end

    it "nicknameがすでに登録されている場合は、登録できないこと" do
      user = create(:user)
      another_user = build(:user, nickname: user.nickname)
      another_user.valid?
      expect(another_user.errors[:nickname]).to include("はすでに存在します")
    end

    it "emailがすでに登録されている場合は、登録できないこと" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    it "nicknameが7文字以上の場合は、登録できないこと" do
      user = build(:user, nickname: "ながいながいまん")
      user.valid?
      expect(user.errors[:nickname]).to include("は6文字以内で入力してください")
    end

    it "nicknameが6文字以下であれば登録できること" do
      user = build(:user, nickname: "たけし")
      user.valid?
      expect(user).to be_valid
    end

    it "passwordが6文字以上であれば登録できること" do
      user = build(:user, password: "000000", password_confirmation: "000000")
      user.valid?
      expect(user).to be_valid
    end

    it "passwordが5文字以下であれば登録できないこと " do
      user = build(:user, password: "00000", password_confirmation: "00000")
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end

    it "introductionが180文字以内であれば、登録できること" do
      user = build(:user, introduction: "短い文はオーケーです")
      user.valid?
      expect(user).to be_valid
    end

    it "introductionが180文字以上の場合、登録できないこと" do
      user = build(:user, introduction: "テストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテストテスト")
      user.valid?
      expect(user.errors[:introduction]).to include("は180文字以内で入力してください")
    end

    it "サイトのURLとして正しくない場合、登録できないこと" do
      user = build(:user, URL: "aaaaaaaaa")
      user.valid?
      expect(user.errors[:URL]).to include("は不正なURLです")
    end

    it "サイトのURLとして正しければ登録できること" do
      user = build(:user, URL: "https://www.tsumiage.site/")
      user.valid?
      expect(user).to be_valid
    end

    it { is_expected.to validate_url_of(:URL) }

  end
end