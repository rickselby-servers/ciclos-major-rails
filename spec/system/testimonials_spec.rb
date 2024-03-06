# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Testimonials", :logged_in do
  include ActionView::RecordIdentifier

  it "allows the user to create a new Testimonial" do
    visit testimonials_path
    click_on "New Testimonial"
    fill_in "Title", with: "Someone's Name"
    fill_in "Text", with: "Best. Holiday. Ever."
    click_on "Create"

    expect(page).to have_text "Someone's Name"
    expect(page).to have_text "Best. Holiday. Ever."
  end

  context "with an existing Testimonial" do
    let!(:testimonial) { create :testimonial }

    it "allows editing of the Testimonial" do
      visit testimonials_path

      expect(page).to have_text testimonial.title
      expect(page).to have_text testimonial.text

      click_on "Edit Testimonial"
      fill_in "Title", with: "Someone's Name"
      fill_in "Text", with: "Best. Holiday. Ever."
      click_on "Update"

      expect(page).to have_text "Someone's Name"
      expect(page).to have_text "Best. Holiday. Ever."
    end

    it "allows deleting of the Testimonial" do
      visit testimonials_path

      expect(page).to have_text testimonial.title
      expect(page).to have_text testimonial.text

      click_on "Edit Testimonial"
      click_on "Delete"

      expect(page).to have_no_text testimonial.title
      expect(page).to have_no_text testimonial.text
    end
  end

  context "with a few Testimonials", :js do
    # rubocop:disable RSpec/IndexedLet
    let!(:testimonial1) { create :testimonial }
    let!(:testimonial2) { create :testimonial }
    # rubocop:enable RSpec/IndexedLet

    it "allows the order to be changed" do
      visit testimonials_path

      element = find("##{dom_id testimonial2} .sortable-handle")
      target = find("##{dom_id testimonial1}")

      element.drag_to target

      expect(page.find("#testimonials > div:first-child")).to have_text testimonial1.title
      expect(page.find("#testimonials > div:nth-child(2)")).to have_text testimonial2.title

      expect(testimonial2.reload.position).to eq 1
      expect(testimonial1.reload.position).to eq 0
    end
  end
end
