class RemoveCaptionFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :caption, :text
  end
end
