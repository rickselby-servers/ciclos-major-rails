# frozen_string_literal: true

require "rails_helper"

RSpec.describe "faqs/show" do
  before do
    assign(:faq, Faq.create!(
                   question: "Question",
                   answer:   "MyText",
                 ),)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Question/)
    expect(rendered).to match(/MyText/)
  end
end
