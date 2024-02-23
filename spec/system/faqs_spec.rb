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
end
