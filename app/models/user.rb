class User < ApplicationRecord
    attr_accessor :password_confirm

    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, confirmation: true, length: { minimum: 2 }
    
    has_many :events
    has_many :events, through: :histories
end
