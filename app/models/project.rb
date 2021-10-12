class Project < ApplicationRecord
  enum status: {'活動中': 0, '一時中止': 1, '終了': 2}


end
