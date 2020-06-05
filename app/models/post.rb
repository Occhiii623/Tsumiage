class Post < ApplicationRecord

  acts_as_taggable_on :labels
  acts_as_taggable
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  validate :tag_list_count
  validate :tag_character_length
  validates :text, presence: true, length: { maximum: 300 }
  mount_uploader :image, ImageUploader

  private
  def tag_list_count
    errors[:tag_list] << "登録できるタグ数は最大5つまでです" if tag_list.count > 5
  end

  def tag_character_length
    self.tag_list.each do |tag|
      errors[:tag_list] << "#{tag}のタグ名は7文字以内にしてください" if tag.length > 10
    end
  end

  def self.search(search)
    return Post.all unless search
    Post.where('text LIKE(?)', "%#{search}%")
  end

end