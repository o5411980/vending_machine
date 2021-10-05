class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :requester
      t.integer :stage
      t.text :description
      t.integer :former_review
      t.datetime :date_on
      t.datetime :deadline
      t.boolean :judge, default: false
      t.text :comment

      t.timestamps
    end
  end
end
