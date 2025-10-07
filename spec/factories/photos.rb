FactoryBot.define do
  factory :photo do
    property { nil }
    cloudinary_id { "MyString" }
    url { "MyString" }
    position { 1 }
    is_primary { false }
  end
end
