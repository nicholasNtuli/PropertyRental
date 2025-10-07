FactoryBot.define do
  factory :property do
    user { nil }
    title { "MyString" }
    description { "MyText" }
    location { "MyString" }
    city { "MyString" }
    country { "MyString" }
    latitude { "9.99" }
    longitude { "9.99" }
    price_per_night { "9.99" }
    property_type { 1 }
    bedrooms { 1 }
    bathrooms { 1 }
    guests { 1 }
    status { 1 }
    featured { false }
  end
end
