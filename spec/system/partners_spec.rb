# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Partners", :logged_in do
  include ActionView::RecordIdentifier

  it "allows the user to create a new guide" do
    visit partners_path
    click_on "New Partner"
    fill_in "Name", with: "Bob Co"
    fill_in "Details", with: "is company"
    fill_in "Url", with: "http://test.test"
    attach_file "Logo", file_fixture("example.jpg")
    click_on "Create"

    expect(page).to have_text "Bob Co"
  end

  context "with an existing partner" do
    let!(:partner) { create :partner }
    let(:logo_url) { url_for partner.logo }

    it "shows the partner logo on the home page" do
      visit root_path

      expect(page).to have_css "img[src='#{logo_url}']"
    end

    it "allows editing of the partner" do
      visit partners_path

      expect(page).to have_text partner.name

      click_on "Edit"
      fill_in "Name", with: "Bob Co"
      fill_in "Details", with: "is company"
      fill_in "Url", with: "http://test.test"
      click_on "Update"

      expect(page).to have_text "Bob Co"
    end

    it "allows deleting of the guide" do
      visit partners_path

      expect(page).to have_text partner.name

      click_on "Edit"
      click_on "Delete"

      expect(page).to have_no_text partner.name
    end
  end

  context "with a few partners", :js do
    # rubocop:disable RSpec/IndexedLet
    let!(:partner1) { create :partner }
    let!(:partner2) { create :partner }
    # rubocop:enable RSpec/IndexedLet

    it "allows the order to be changed" do
      visit partners_path

      element = find("##{dom_id partner1} .sortable-handle")
      target = find("##{dom_id partner2}")

      element.drag_to target

      expect(page.find("#partners tbody tr:first-child")).to have_text partner2.name
      expect(page.find("#partners tbody tr:nth-child(2)")).to have_text partner1.name

      expect(partner1.reload.position).to eq 1
      expect(partner2.reload.position).to eq 0
    end
  end
end
