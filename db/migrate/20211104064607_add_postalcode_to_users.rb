class AddPostalcodeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :postalcode, :string
  end
end
