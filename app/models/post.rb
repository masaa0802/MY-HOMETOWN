class Post < ApplicationRecord
  has_one_attached :video
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
