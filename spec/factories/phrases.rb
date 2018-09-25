FactoryBot.define do
  factory :phrase do
    actor { "A" }
    sequence(:start_in_sec) { |n| n}
    sequence(:end_in_sec) { |n| n + 5 }
    content { "Hey Mike. I heard about your break up. You must be devastated." }
  end
end
