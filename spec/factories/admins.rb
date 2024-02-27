# frozen_string_literal: true

FactoryBot.define do
  factory :admin do
    sequence(:email) { |n| "test#{n}@test.com" }
  end
end
