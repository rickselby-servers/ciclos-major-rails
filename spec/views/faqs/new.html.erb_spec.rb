# frozen_string_literal: true

require "rails_helper"

RSpec.describe "faqs/new" do
  before do
    assign(:faq, Faq.new(
                   question: "MyString",
                   answer:   "MyText",
                 ),)
  end

  it "renders new faq form" do
    render

    assert_select "form[action=?][method=?]", faqs_path, "post" do
      assert_select "input[name=?]", "faq[question]"

      assert_select "textarea[name=?]", "faq[answer]"
    end
  end
end
