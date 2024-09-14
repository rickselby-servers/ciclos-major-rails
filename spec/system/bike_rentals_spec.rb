# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Bike Rentals", :logged_in do
  include ActionView::RecordIdentifier

  it "does not fail if description is not filled in", :js do
    visit bike_rentals_path
    click_on "New Bike Rental"
    fill_in "Name", with: "Bob"

    click_on "Change Image"
    attach_file "Photo", file_fixture("400x400.jpg")
    sleep 0.2
    click_on "Save"

    click_on "Create"

    expect(page).to have_text "One error prevented this bike rental from being saved"
  end

  it "allows the user to create a new bike rental", :js do
    visit bike_rentals_path
    click_on "New Bike Rental"
    fill_in "Name", with: "Bob"

    within_frame("bike_rental_description_ifr") { page.find_by_id("tinymce").set("is bike") }

    click_on "Change Image"
    attach_file "Photo", file_fixture("400x400.jpg")
    sleep 0.2
    click_on "Save"

    click_on "Add another detail"
    # find_by_id(/bike_rental_bike_rental_details_attributes_\d+_key/).set("Wheels")
    fill_in "Key", with: "Wheels"
    fill_in "Value", with: "2"

    click_on "Create"

    expect(page).to have_text "Bob"
    expect(page).to have_text "is bike"
    expect(page).to have_text "Wheels: 2"
  end
end
