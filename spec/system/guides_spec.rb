# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Guides" do
  include ActionView::RecordIdentifier

  before { sign_in Admin.create }

  let(:photo) { file_fixture_upload("example.jpg") }

  it "allows the user to create a new FAQ" do
    visit guides_path
    click_on "New Guide"
    fill_in "Name", with: "Bob"
    fill_in "Description", with: "is person"
    attach_file "Photo", file_fixture("example.jpg")
    click_on "Create"

    expect(page).to have_text "Bob"
    expect(page).to have_text "is person"
  end

  context "with an existing guide" do
    before { Guide.create! name: "Bob", description: "is person", photo: }

    it "allows editing of the guide" do
      visit guides_path

      expect(page).to have_text "Bob"

      click_on "Edit Guide"
      fill_in "Name", with: "Bill"
      fill_in "Description", with: "is still person"
      click_on "Update"

      expect(page).to have_text "Bill"
      expect(page).to have_text "is still person"
    end

    it "allows deleting of the guide" do
      visit guides_path

      expect(page).to have_text "Bob"

      click_on "Edit Guide"
      click_on "Delete"

      expect(page).to have_no_text "Bob"
    end
  end

  context "with a few guides", :js do
    # rubocop:disable RSpec/IndexedLet
    let!(:guide1) { Guide.create! name: "Bob", description: "is person", photo: }
    let!(:guide2) { Guide.create! name: "Bill", description: "is also person", photo: }
    # rubocop:enable RSpec/IndexedLet

    it "allows the order to be changed" do
      visit guides_path

      element = find("##{dom_id guide1} .sortable-handle")
      target = find("##{dom_id guide2}")

      element.drag_to target

      expect(page.find("#guides > div:first-child")).to have_text "Bill"
      expect(page.find("#guides > div:nth-child(2)")).to have_text "Bob"

      expect(guide1.reload.position).to eq 1
      expect(guide2.reload.position).to eq 0
    end
  end
end
