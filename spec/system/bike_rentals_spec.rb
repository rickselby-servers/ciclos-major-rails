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
    sleep 0.5 # yuck! but required...
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
    sleep 0.5 # yuck! but required...
    click_on "Save"

    click_on "Add another detail"
    fill_in "Key", with: "Wheels"
    fill_in "Value", with: "2"

    click_on "Add another price"
    fill_in "Days", with: "4"
    fill_in "Total price", with: "98"

    click_on "Create"

    expect(page).to have_text "Bob"
    expect(page).to have_text "is bike"
    expect(page).to have_text "Wheels: 2"
    expect(page).to have_text "€24.50"
  end

  context "with an existing bike rental" do
    let!(:bike_rental) { create :bike_rental, :with_detail, :with_prices }

    it "allows editing of the rental" do
      visit bike_rentals_path

      expect(page).to have_text bike_rental.name

      click_on "Edit Bike Rental"
      fill_in "Name", with: "Penny Farthing"
      fill_in "Description", with: "is old bike"
      click_on "Update"

      expect(page).to have_text "Penny Farthing"
      expect(page).to have_text "is old bike"
    end

    it "allows adding a new detail", :js do
      visit bike_rentals_path
      click_on "Edit Bike Rental"

      click_on "Add another detail"
      fill_in "Key", currently_with: "", with: "Wheels"
      fill_in "Value", currently_with: "", with: "2"
      click_on "Update"

      expect(page).to have_text "Wheels: 2"
    end

    it "allows adding a new price", :js do
      visit bike_rentals_path
      click_on "Edit Bike Rental"

      click_on "Add another price"
      fill_in "Days", currently_with: "", with: "4"
      fill_in "Total price", currently_with: "", with: "98"
      click_on "Update"

      expect(page).to have_text "€24.50"
    end

    it "allows editing a detail", :js do
      visit bike_rentals_path
      click_on "Edit Bike Rental"

      fill_in "Key", currently_with: bike_rental.bike_rental_details.first.key, with: "Wheels"
      fill_in "Value", currently_with: bike_rental.bike_rental_details.first.value, with: "2"
      click_on "Update"

      expect(page).to have_text "Wheels: 2"
    end

    it "allows editing a price", :js do
      visit bike_rentals_path
      click_on "Edit Bike Rental"

      fill_in "Days", currently_with: bike_rental.bike_rental_prices.first.days, with: "4"
      fill_in "Total price", currently_with: bike_rental.bike_rental_prices.first.total_price, with: "98"
      click_on "Update"

      expect(page).to have_text "€24.50"
    end

    it "allows deleting of the bike rental" do
      visit bike_rentals_path

      expect(page).to have_text bike_rental.name

      click_on "Edit Bike Rental"
      click_on "Delete"

      expect(page).to have_no_text bike_rental.name
    end
  end

  context "with a few bike rentals", :js do
    # rubocop:disable RSpec/IndexedLet
    let!(:bike_rental1) { create :bike_rental }
    let!(:bike_rental2) { create :bike_rental }
    # rubocop:enable RSpec/IndexedLet

    it "allows the order to be changed" do
      visit bike_rentals_path

      element = find("##{dom_id bike_rental1} .sortable-handle")
      target = find("##{dom_id bike_rental2}")

      element.drag_to target

      expect(page.find("#bike_rentals > div:first-child")).to have_text bike_rental2.name
      expect(page.find("#bike_rentals > div:nth-child(2)")).to have_text bike_rental1.name

      expect(bike_rental1.reload.position).to eq 1
      expect(bike_rental2.reload.position).to eq 0
    end
  end
end
