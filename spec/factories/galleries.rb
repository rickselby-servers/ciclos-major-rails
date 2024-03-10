# frozen_string_literal: true

FactoryBot.define do
  factory :gallery do
    name { generate :text_content }
    date { Date.current }

    trait :invalid do
      name { "" }
      date { "" }
    end
  end
end
