# frozen_string_literal: true

FactoryBot.define do
  factory :partner do
    name { generate :text_content }
    details { generate :text_content }
    url { generate :text_content }
    logo { Rack::Test::UploadedFile.new "spec/fixtures/files/example.jpg", "image/jpg" }

    trait :html do
      details { "<strong>#{generate :text_content}</strong>" }
    end

    trait :invalid do
      name { "" }
      details { "" }
      url { "" }
      logo { nil }
    end
  end
end
