class CreateReviewDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :review_documents do |t|
      t.references :document, foreign_key: true
      t.references :review, foreign_key: true

      t.timestamps
    end
  end
end
