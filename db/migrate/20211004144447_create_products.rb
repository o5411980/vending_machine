class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :category
      t.string :description
      t.integer :status
      t.integer :location

      t.timestamps
    end
  end
end
