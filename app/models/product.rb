class Product < ApplicationRecord
  has_many :documents, dependent: :destroy

  enum category: {'マウス': 1, 'キーボード': 2, 'バッテリー': 3}
  enum status: {'開発中': 0, '製造中': 1, '製造中止': 2}
  enum location: {'未定': 0, '東京': 1, '深圳': 2, 'バンコク': 2, 'デュッセルドルフ': 3, 'ダラス': 4}
end
