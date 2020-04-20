class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :item
  
  validates :content, presence: true, length: { minimum: 2 }

  # 在model預設反向排序comment
  default_scope { where(deleted_at: nil).order(id: :desc) }
end