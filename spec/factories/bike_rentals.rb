# frozen_string_literal: true

FactoryBot.define do
  factory :bike_rental do
    name { generate :text_content }
    description { generate :text_content }
    photo { Rack::Test::UploadedFile.new "spec/fixtures/files/400x400.jpg", "image/jpg" }

    trait :html do
      description { "<strong>#{generate :text_content}</strong>" }
    end

    trait :with_detail do
      transient do
        details_count { 5 }
      end

      after(:create) do |bike_rental, evaluator|
        create_list :bike_rental_detail, evaluator.details_count, bike_rental:
      end
    end

    trait :with_detail_attributes do
      bike_rental_details_attributes { [attributes_for(:bike_rental_detail)] }
    end

    trait :invalid do
      name { "" }
      description { "" }
      photo { nil }
    end
  end
end
