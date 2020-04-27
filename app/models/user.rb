class User < ApplicationRecord
    attr_accessor :password_confirm
    # validations
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, confirmation: true, length: { minimum: 2 }
    
    # relationships
    has_many :histories
    has_many :events, through: :histories
    has_many :comments
    has_many :favorite_items
    has_many :items, through: :favorite_items
    has_many :orders
end
