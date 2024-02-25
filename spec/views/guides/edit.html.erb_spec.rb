# frozen_string_literal: true

require "rails_helper"

RSpec.describe "guides/edit" do
  let(:guide) do
    Guide.create!(
      name:        "MyString",
      description: "MyText",
      photo:       nil,
    )
  end

  before do
    assign(:guide, guide)
  end

  it "renders the edit guide form" do
    render

    assert_select "form[action=?][method=?]", guide_path(guide), "post" do
      assert_select "input[name=?]", "guide[name]"

      assert_select "textarea[name=?]", "guide[description]"

      assert_select "input[name=?]", "guide[photo]"
    end
  end
end
