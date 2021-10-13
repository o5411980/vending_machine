class ReviewDocument < ApplicationRecord
  belongs_to :document
  belongs_to :review
end
