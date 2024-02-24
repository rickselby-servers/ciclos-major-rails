# frozen_string_literal: true

require "rails_helper"

RSpec.describe "FAQs" do
  include ActionView::RecordIdentifier

  before { sign_in Admin.create }

  it "allows the user to create a new FAQ" do
    visit faqs_path
    click_on "New FAQ"
    fill_in "Question", with: "A test question"
    fill_in "Answer", with: "A test answer"
    click_on "Create"

    expect(page).to have_text "A test question"
  end

  context "with an existing FAQ" do
    before { Faq.create! question: "Initial question", answer: "foo" }

    it "allows editing of the FAQ" do
      visit faqs_path

      expect(page).to have_text "Initial question"

      click_on "Edit FAQ"
      fill_in "Question", with: "A test question"
      fill_in "Answer", with: "A test answer"
      click_on "Update"

      expect(page).to have_text "A test question"
    end

    it "allows deleting of the FAQ" do
      visit faqs_path

      expect(page).to have_text "Initial question"

      click_on "Edit FAQ"
      click_on "Delete"

      expect(page).to have_no_text "Initial question"
    end
  end

  context "with a few FAQs", :js do
    # rubocop:disable RSpec/IndexedLet
    let!(:faq1) { Faq.create! question: "Question 1", answer: "foo" }
    let!(:faq2) { Faq.create! question: "Question 2", answer: "foo" }
    # rubocop:enable RSpec/IndexedLet

    it "allows the order to be changed" do
      visit faqs_path

      element = find("##{dom_id faq1} .sortable-handle")
      target = find("##{dom_id faq2}")

      element.drag_to target

      expect(page.find("#faqs > div:first-child")).to have_text "Question 2"
      expect(page.find("#faqs > div:nth-child(2)")).to have_text "Question 1"

      expect(faq1.reload.position).to eq 1
      expect(faq2.reload.position).to eq 0
    end
  end
end
