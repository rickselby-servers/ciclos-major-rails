# frozen_string_literal: true

FactoryBot.define do
  factory :bike_rental_price do
    bike_rental
    sequence(:days) { |n| n }
    sequence(:total_price) { |n| 1000 + n }

    trait :invalid do
      key { "" }
      value { "" }
    end
  end
end
