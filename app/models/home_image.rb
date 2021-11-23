class HomeImage < ApplicationRecord
  mount_uploader :image, HomeImageUploader
end
