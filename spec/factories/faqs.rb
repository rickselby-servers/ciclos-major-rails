# frozen_string_literal: true

FactoryBot.define do
  factory :faq do
    question { question_content }
    answer { answer_content }

    trait :html do
      answer { "<strong>#{answer_content}</strong>" }
    end

    trait :invalid do
      question { "" }
      answer { "" }
    end

    transient do
      sequence(:question_content, "aaa") { |t| "a question with the letters #{t}" }
      sequence(:answer_content, "aaa") { |t| "an answer with the letters #{t}" }
    end
  end
end
