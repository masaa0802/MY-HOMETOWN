class AddPostIdToVideos < ActiveRecord::Migration[5.2]
  def change
    add_column :videos, :post_id, :integer
  end
end
