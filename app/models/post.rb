class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :text, presence: true, length: { maximum: 300 }
  mount_uploader :image, ImageUploader
end
