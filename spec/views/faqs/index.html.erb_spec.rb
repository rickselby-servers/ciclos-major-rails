# frozen_string_literal: true

require "rails_helper"

RSpec.describe "faqs/index" do
  before do
    assign(:faqs, [
             Faq.create!(
               question: "Question",
               answer:   "MyText",
             ),
             Faq.create!(
               question: "Question",
               answer:   "MyText",
             ),
           ],)
  end

  it "renders a list of faqs" do
    render
    assert_select "div>div>h2>div>button", text: Regexp.new("Question".to_s), count: 2
    assert_select "div>div>div>div", text: Regexp.new("MyText".to_s), count: 2
  end
end
