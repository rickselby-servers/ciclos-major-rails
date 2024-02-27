# frozen_string_literal: true

FactoryBot.define do
  factory :page_text do
    key { :foo }
    text { generate :text_content }

    trait :html do
      text { "<strong>#{generate :text_content}</strong>" }
    end
  end
end
