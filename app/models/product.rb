class Product < ApplicationRecord
  has_many :documents, dependent: :destroy
end
