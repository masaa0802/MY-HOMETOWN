class Post < ApplicationRecord
  has_one_attached :video
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :caption, presence: true, length: {maximum: 200}

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  def like_by(user)
    likes.find_by(user_id: user.id)
  end
end
