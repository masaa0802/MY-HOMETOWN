class RemoveTelephoneFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :telephone, :string
  end
end
