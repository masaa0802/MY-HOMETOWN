class RemoveCaptionFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :caption, :text
  end
end
