class AddProductRefToDocuments < ActiveRecord::Migration[5.2]
  def change
    add_reference :documents, :product, foreign_key: true
  end
end
