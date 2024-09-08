# frozen_string_literal: true

FactoryBot.define do
  factory :bike_rental_detail do
    bike_rental
    key { generate :text_content }
    value { generate :text_content }

    trait :invalid do
      key { "" }
      value { "" }
    end
  end
end
