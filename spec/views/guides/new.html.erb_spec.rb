# frozen_string_literal: true

require "rails_helper"

RSpec.describe "guides/new" do
  before do
    assign(:guide, Guide.new(
                     name:        "MyString",
                     description: "MyText",
                     photo:       nil,
                   ),)
  end

  it "renders new guide form" do
    render

    assert_select "form[action=?][method=?]", guides_path, "post" do
      assert_select "input[name=?]", "guide[name]"

      assert_select "textarea[name=?]", "guide[description]"

      assert_select "input[name=?]", "guide[photo]"
    end
  end
end
