# frozen_string_literal: true

require "rails_helper"

RSpec.describe "photos/edit" do
  let(:photo) { create :photo }

  before { assign :photo, photo }

  it { is_expected.to have_css "form[action='#{photo_path(photo)}'][method='post']" }

  context "with the edit form" do
    subject { page.find("form##{dom_id(photo, :edit_form)}") }

    it { is_expected.to have_field "photo[alt]" }
    it { is_expected.to have_button "commit" }
  end

  context "with the delete form" do
    subject { page.find("form##{dom_id(photo, :delete_form)}") }

    it { is_expected.to have_button "commit" }
  end
end
