# frozen_string_literal: true

require "rails_helper"

RSpec.describe "FAQs", :logged_in do
  include ActionView::RecordIdentifier

  it "allows the user to create a new FAQ" do
    visit faqs_path
    click_on "New FAQ"
    fill_in "Question", with: "A test question"
    fill_in "Answer", with: "A test answer"
    click_on "Create"

    expect(page).to have_text "A test question"
  end

  context "with an existing FAQ" do
    let!(:faq) { create :faq }

    it "allows editing of the FAQ" do
      visit faqs_path

      expect(page).to have_text faq.question

      click_on "Edit FAQ"
      fill_in "Question", with: "A test question"
      fill_in "Answer", with: "A test answer"
      click_on "Update"

      expect(page).to have_text "A test question"
    end

    it "allows deleting of the FAQ" do
      visit faqs_path

      expect(page).to have_text faq.question

      click_on "Edit FAQ"
      click_on "Delete"

      expect(page).to have_no_text faq.question
    end
  end

  context "with a few FAQs", :js do
    # rubocop:disable RSpec/IndexedLet
    let!(:faq1) { create :faq }
    let!(:faq2) { create :faq }
    # rubocop:enable RSpec/IndexedLet

    it "allows the order to be changed" do
      visit faqs_path

      element = find("##{dom_id faq1} .sortable-handle")
      target = find("##{dom_id faq2}")

      element.drag_to target

      expect(page.find("#faqs > div:first-child")).to have_text faq2.question
      expect(page.find("#faqs > div:nth-child(2)")).to have_text faq1.question

      expect(faq1.reload.position).to eq 1
      expect(faq2.reload.position).to eq 0
    end
  end
end
