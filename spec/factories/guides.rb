# frozen_string_literal: true

FactoryBot.define do
  factory :guide do
    name { name_content }
    description { description_content }
    photo { Rack::Test::UploadedFile.new "spec/fixtures/files/example.jpg", "image/jpg" }

    trait :html do
      description { "<strong>#{description_content}</strong>" }
    end

    trait :invalid do
      name { "" }
      description { "" }
      photo { nil }
    end

    transient do
      sequence(:name_content, "aaa") { |t| "a name with the letters #{t}" }
      sequence(:description_content, "aaa") { |t| "a description with the letters #{t}" }
    end
  end
end
