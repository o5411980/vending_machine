class Document < ApplicationRecord
  mount_uploader :filepath, DocumentUploader
end
