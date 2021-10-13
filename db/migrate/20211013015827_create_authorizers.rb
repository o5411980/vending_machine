class CreateAuthorizers < ActiveRecord::Migration[5.2]
  def change
    create_table :authorizers do |t|
      t.references :user, foreign_key: true
      t.references :document, foreign_key: true

      t.timestamps
    end
  end
end
