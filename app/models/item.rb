class Item < ApplicationRecord
    validates :name, presence: true
    validates :price, presence: true, numericality: { greater_than: 0 }
    # 驗證價錢有填寫且要大於0

    belongs_to :category
    has_one_attached :cover
    has_many :comments
    has_many :favorite_items
    has_many :users, through: :favorite_items

    # scope :available, -> { where(delete_at: nil) }
    default_scope { where(delete_at: nil) }

    def destroy
        update(delete_at: Time.now)
    end

    def favorited_by(u)
        u.items.include?(self)
    end

end
