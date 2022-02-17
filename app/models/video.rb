class Video < ApplicationRecord
  has_one_attached :video
  validates :caption, presence: true, length: { maximum: 200 }
  belongs_to :user
  belongs_to :post
  
  validate :video_type, :video_size, :video_length

  private

  def video_type
    videos.each do |video|
      if !video.blob.content_type.in?(%('MOV/wmv/mp4'))
        video.purge
        errors.add(:video, 'はMOV,wmv,mp4形式でアップロードしてください')
      end
    end
  end

  def video_size
    videos.each do |video|
      if video.blob.byte_size > 5.megabytes
        video.purge
        errors.add(:video, "は1つのファイル5MB以内にしてください")
      end
    end
  end

  def video_length
    if videos.length < 1
      videos.purge
      errors.add(:video, "は1つにしてください")
    end
  end
end
