# frozen_string_literal: true

require "rails_helper"
require_relative "shared/photo_list"

RSpec.describe "Galleries", :logged_in do
  include ActionView::RecordIdentifier

  it "allows the user to create a new gallery" do
    visit galleries_path
    click_on "New Gallery"
    fill_in "Name", with: "A gallery name"
    fill_in "Date", with: "2024-03-16"
    click_on "Create"

    expect(page).to have_text "A gallery name"
  end

  context "with an existing gallery" do
    let!(:gallery) { create :gallery }

    it "allows editing of the gallery" do
      visit galleries_path
      click_on gallery.name
      click_on "Edit Gallery"
      fill_in "Name", with: "A gallery name"
      fill_in "Date", with: "2024-03-16"
      click_on "Update"

      expect(page).to have_text "A gallery name"
    end

    it "allows deleting of the gallery" do
      visit galleries_path
      click_on gallery.name
      click_on "Edit Gallery"
      click_on "Delete"

      expect(page).to have_no_text gallery.name
    end

    it_behaves_like "it handles a list of photos" do
      let(:model) { gallery }
      let(:path) { gallery_path gallery }
    end
  end
end
