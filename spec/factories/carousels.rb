# frozen_string_literal: true

FactoryBot.define do
  factory :carousel do
    reference { generate :text_content }

    trait :invalid do
      reference { "" }
    end
  end
end
