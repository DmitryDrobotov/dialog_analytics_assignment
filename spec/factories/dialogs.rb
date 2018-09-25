FactoryBot.define do
  factory :dialog do
    name { 'Dialog 53' }

    factory :dialog_with_phrases do
      after(:create) do |dialog|
        create_list(:phrase, 3, dialog: dialog)
      end
    end
  end
end
