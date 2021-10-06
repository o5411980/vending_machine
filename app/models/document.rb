class Document < ApplicationRecord
  mount_uploader :filepath, DocumentUploader
  belongs_to :product
end
