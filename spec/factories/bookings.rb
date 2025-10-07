FactoryBot.define do
  factory :booking do
    property { nil }
    user { nil }
    check_in { "2025-10-07" }
    check_out { "2025-10-07" }
    total_price { "9.99" }
    status { 1 }
    guests_count { 1 }
    special_requests { "MyText" }
  end
end
