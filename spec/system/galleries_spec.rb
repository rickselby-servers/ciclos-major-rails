# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Galleries", :logged_in do
  let(:photo_list) { page.find('#photo-list') }

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

    it "allows adding of a photo", :js do
      visit galleries_path
      click_on gallery.name
      click_on "Add new photos"
      attach_file "Photos", file_fixture("400x400.jpg")
      click_on "Add"

      expect(photo_list).to have_css("img[src*='400x400.jpg']")
    end

    it "allows adding of multiple photos", :js do
      visit galleries_path
      click_on gallery.name
      click_on "Add new photos"
      attach_file "Photos", [file_fixture("400x400.jpg"), file_fixture("400x800.jpg"), file_fixture("800x400.jpg")]
      click_on "Add"

      expect(photo_list).to have_css("img[src*='400x400.jpg']")
      expect(photo_list).to have_css("img[src*='400x800.jpg']")
      expect(photo_list).to have_css("img[src*='800x400.jpg']")
    end

    context "with a photo" do
      before { create :photo, photoable: gallery }

      it "allows the photo to be edited", :js do
        visit galleries_path
        click_on gallery.name
        click_on "Edit photo"
        fill_in "Alt", with: "some alt text"
        click_on "Update"

        expect(photo_list).to have_css("img[alt='some alt text']")
      end

      it "allows the photo to be deleted", :js do
        visit galleries_path
        click_on gallery.name

        expect(photo_list).to have_css("img[src*='400x400.jpg']")

        click_on "Edit photo"
        accept_alert { click_on "Delete" }

        expect(photo_list).to have_no_css("img[src*='400x400.jpg']")
      end
    end
  end
end
