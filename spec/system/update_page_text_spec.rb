# frozen_string_literal: true

require "rails_helper"

RSpec.describe "updating page text" do
  it "allows the user logs in and update some text", :js, :logged_in do
    visit root_path

    page.find("div#pages\\.home\\.block").send_keys "foo"

    click_on "Update"

    expect(page).to have_text "foo"
    expect(PageText.find_by(key: "pages.home.block").text).to include "foo"
  end
end
