# frozen_string_literal: true

FactoryBot.define do
  factory :bike_rental do
    name { generate :text_content }
    description { generate :text_content }
    photo { Rack::Test::UploadedFile.new "spec/fixtures/files/400x400.jpg", "image/jpg" }

    trait :html do
      description { "<strong>#{generate :text_content}</strong>" }
    end

    trait :invalid do
      name { "" }
      description { "" }
      photo { nil }
    end
  end
end
