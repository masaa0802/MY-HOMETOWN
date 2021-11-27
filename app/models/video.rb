class Video < ApplicationRecord
  has_one_attached :video
  validates :caption, presence: true, length: { maximum: 200 }
  belongs_to :user
  belongs_to :post
end
