FactoryBot.define do
  factory :item do
    name    { Faker::Name.name }
    price   { Faker::Number.between(from: 50, to: 300) }
    category
    # 等同於category{ FactoryBot.create(:category) }
  end
end