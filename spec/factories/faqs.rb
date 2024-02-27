# frozen_string_literal: true

FactoryBot.define do
  factory :faq do
    question { generate(:text_content) }
    answer { generate(:text_content) }

    trait :html do
      answer { "<strong>#{generate(:text_content)}</strong>" }
    end

    trait :invalid do
      question { "" }
      answer { "" }
    end
  end
end
