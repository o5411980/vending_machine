class Document < ApplicationRecord
  mount_uploader :filepath, DocumentUploader
  belongs_to :product

  enum category: {'その他文書': 0, 'ビジネスプラン': 1}
  enum authorize: {'未承認': false, '承認済': true}
end
