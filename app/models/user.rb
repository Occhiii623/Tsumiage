class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true, uniqueness: true, length: { maximum: 6 }
  validates :introduction, length: { maximum: 180 }
  validates :URL, url: { allow_blank: true }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  mount_uploader :icon, IconUploader

# 現在パスワードなしでも更新できるように設定
  def update_with_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank?
        params.delete(:password)
        params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    result = update(params, *options)
    clean_up_passwords
    result
  end

  # フォロー機能の設定
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  # ユーザーがすでに対象の投稿にいいねしているか判定
  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end
end
