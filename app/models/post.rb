class Post < ApplicationRecord
  has_one_attached :video
  has_many :likes, dependent: :destroy

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
