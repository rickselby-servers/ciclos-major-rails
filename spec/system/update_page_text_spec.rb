# frozen_string_literal: true

require "rails_helper"

RSpec.describe "updating page text" do
  scenario "user logs in and updates some text", js: true do
    sign_in Admin.create
    visit home_path

    page.find("p#home\\.show\\.block").send_keys "foo"

    click_on "Update Page text"

    expect(page).to have_text "foo"
    expect(PageText.find_by(key: "home.show.block").text).to eq "home.show.blockfoo"
  end
end
