class AddNameMrMsEmployeeNumberIconCommentToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :mr_ms, :integer
    add_column :users, :employee_number, :integer
    add_column :users, :icon, :string
    add_column :users, :comment, :text
  end
end
