# frozen_string_literal: true

FactoryBot.define do
  factory :testimonial do
    title { generate :text_content }
    text { generate :text_content }

    trait :html do
      text { "<strong>#{generate :text_content}</strong>" }
    end

    trait :invalid do
      title { "" }
      text { "" }
    end
  end
end
