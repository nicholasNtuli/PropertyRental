FactoryBot.define do
  factory :jwt_denylist do
    jti { "MyString" }
    exp { "2025-10-07 10:44:25" }
  end
end
