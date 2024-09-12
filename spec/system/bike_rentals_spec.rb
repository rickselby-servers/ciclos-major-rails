# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Bike Rentals", :logged_in do
  include ActionView::RecordIdentifier

  it "allows the user to create a new bike rental" do
    visit bike_rentals_path
    click_on "New Bike Rental"
    fill_in "Name", with: "Bob"
    fill_in "Description", with: "is bike"
    attach_file "Photo", file_fixture("400x400.jpg")
    click_on "Create"

    expect(page).to have_text "Bob"
    expect(page).to have_text "is bike"
  end
end
