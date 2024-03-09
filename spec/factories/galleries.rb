# frozen_string_literal: true

FactoryBot.define do
  factory :gallery do
    name { generate :text_content }
    date { Date.current }
    photos { [Rack::Test::UploadedFile.new("spec/fixtures/files/400x400.jpg", "image/jpg")] }

    trait :invalid do
      name { "" }
      date { "" }
    end
  end
end
