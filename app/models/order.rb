class Order < ApplicationRecord
    has_many :order_items
    belongs_to :user

    before_create :create_order_num

    private
    def create_order_num
        self.order_num = num_generator
    end

    def num_generator
        t = Date.today
        year = t.year
        month = t.month
        day = t.day
        code = [*0..9, *'A'..'Z'].sample(6).join
        "#{year}#{"%02d" % month}#{"02d" % day}#{code}"
    end
end
