class RemovePostalcodeFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :postalcode, :string
  end
end
