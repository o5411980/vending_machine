class AddAdminMessageColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin_message, :text
  end
end
