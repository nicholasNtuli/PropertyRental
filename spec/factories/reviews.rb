FactoryBot.define do
  factory :review do
    property { nil }
    user { nil }
    rating { "9.99" }
    comment { "MyText" }
  end
end
