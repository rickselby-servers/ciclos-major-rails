# frozen_string_literal: true

FactoryBot.define do
  factory :season do
    name { generate :text_content }
    description { generate :text_content }
    photo { Rack::Test::UploadedFile.new "spec/fixtures/files/400x400.jpg", "image/jpg" }
    launch_date { 2.days.ago.to_date }
    start_date { 1.day.ago.to_date }
    end_date { 1.day.from_now.to_date }

    trait :invalid do
      name { nil }
      description { nil }
      photo { nil }
      launch_date { nil }
      start_date { nil }
      end_date { nil }
    end

    trait :future do
      launch_date { 1.day.from_now.to_date }
      start_date { 2.days.from_now.to_date }
      end_date { 3.days.from_now.to_date }
    end

    trait :past do
      launch_date { 3.days.ago.to_date }
      start_date { 2.days.ago.to_date }
      end_date { 1.day.ago.to_date }
    end

    trait :launched do
      launch_date { 1.day.ago.to_date }
      start_date { 1.day.from_now.to_date }
      end_date { 2.days.from_now.to_date }
    end
  end
end
