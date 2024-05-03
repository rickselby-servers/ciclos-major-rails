# frozen_string_literal: true

RSpec.shared_examples "it handles a list of photos" do
  let(:photo_list) { page.find_by_id("photo-list") }

  it "allows adding of a photo", :js do
    visit path
    click_on "Add new photos"
    attach_file "Photos", file_fixture("400x400.jpg")
    click_on "Add"

    expect(photo_list).to have_css("img[src*='400x400.jpg']")
  end

  it "allows adding of multiple photos", :js do
    visit path
    click_on "Add new photos"
    attach_file "Photos", [file_fixture("400x400.jpg"), file_fixture("400x800.jpg"), file_fixture("800x400.jpg")]
    click_on "Add"

    expect(photo_list).to have_css("img[src*='400x400.jpg']")
    expect(photo_list).to have_css("img[src*='400x800.jpg']")
    expect(photo_list).to have_css("img[src*='800x400.jpg']")
  end

  context "with a photo" do
    before { create :photo, photoable: model }

    it "allows the photo to be edited", :js do
      visit path
      click_on "Edit photo"
      fill_in "Alt", with: "some alt text"
      click_on "Update"

      expect(photo_list).to have_css("img[alt='some alt text']")
    end

    it "allows the photo to be deleted", :js do
      visit path

      expect(photo_list).to have_css("img[src*='400x400.jpg']")

      click_on "Edit photo"
      accept_alert { click_on "Delete" }

      expect(photo_list).to have_no_css("img[src*='400x400.jpg']")
    end
  end

  context "with a few photos", :js do
    # rubocop:disable RSpec/IndexedLet
    let!(:photo1) { create :photo, photoable: model, alt: "photo1" }
    let!(:photo2) { create :photo, photoable: model, alt: "photo2" }
    # rubocop:enable RSpec/IndexedLet

    it "allows the order to be changed" do
      visit path

      element = find("##{dom_id photo1}")
      target = find("##{dom_id photo2}")

      element.drag_to target

      expect(page.find("#photo-list > div > div:first-child")).to have_css("img[alt='photo2']")
      expect(page.find("#photo-list > div > div:nth-child(2)")).to have_css("img[alt='photo1']")

      expect(photo1.reload.position).to eq 1
      expect(photo2.reload.position).to eq 0
    end
  end
end
