FactoryBot.define do
  factory :registration do
    name { "MyString" }
    surname { "MyString" }
    age { 1 }
    contact_no { "MyString" }
    user { nil }
    activity { nil }
  end
end
