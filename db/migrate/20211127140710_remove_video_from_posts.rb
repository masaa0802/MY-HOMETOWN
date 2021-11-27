class RemoveVideoFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :video, :string
  end
end
