class AddFilepathToDocuments < ActiveRecord::Migration[5.2]
  def change
    add_column :documents, :filepath, :string
  end
end
