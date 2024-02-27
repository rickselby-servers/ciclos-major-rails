# frozen_string_literal: true

FactoryBot.define do
  factory :page_text do
    key { :foo }
    text { text_content }

    trait :html do
      text { "<strong>#{text_content}</strong>" }
    end

    transient do
      sequence(:text_content, "aaa") { |t| "some text with the letters #{t}" }
    end
  end
end
