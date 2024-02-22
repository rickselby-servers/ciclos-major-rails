# frozen_string_literal: true

require "rails_helper"

RSpec.describe "updating page text" do
  it "allows the user logs in and update some text", :js do
    sign_in Admin.create
    visit root_path

    page.find("p#pages\\.home\\.block").send_keys "foo"

    click_on "Update"

    expect(page).to have_text "foo"
    expect(PageText.find_by(key: "pages.home.block").text).to include "foo"
  end
end
