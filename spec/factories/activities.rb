FactoryBot.define do
  factory :activity do
    category { nil }
    title { "MyString" }
    user { nil }
    description { "MyText" }
    price { 1 }
  end
end
