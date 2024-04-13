# frozen_string_literal: true

FactoryBot.define do
  factory :photo do
    photoable factory: :gallery
    alt { generate :text_content }
    photo { Rack::Test::UploadedFile.new "spec/fixtures/files/400x400.jpg", "image/jpg" }

    trait :invalid do
      photo { nil }
    end
  end
end
