class Document < ApplicationRecord
  mount_uploader :filepath, DocumentUploader
  belongs_to :product

  enum category: {'その他文書': 0, 'ビジネスプラン': 1, 'マスタープラン': 2, '製品仕様書': 3, '設計書': 4, '試作報告書': 5, '量産試作報告書': 6, '歩留り評価報告書': 7, '作業手順書': 8, '議事録': 9 }
  enum authorize: {'未承認': false, '承認済': true}
end
