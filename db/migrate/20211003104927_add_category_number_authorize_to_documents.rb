class AddCategoryNumberAuthorizeToDocuments < ActiveRecord::Migration[5.2]
  def change
    add_column :documents, :category, :integer, defalt: 0
    add_column :documents, :control_number, :integer
    add_column :documents, :authorize, :boolean, defalt: false
  end
end
