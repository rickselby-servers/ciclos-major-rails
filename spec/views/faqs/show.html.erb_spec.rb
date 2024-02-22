# frozen_string_literal: true

require "rails_helper"

RSpec.describe "faqs/show" do
  subject do
    render
    rendered
  end

  before { assign(:faq, Faq.create!(question: "Question", answer: "MyText")) }

  it { is_expected.to match(/Question/) }
  it { is_expected.to match(/MyText/) }
end
