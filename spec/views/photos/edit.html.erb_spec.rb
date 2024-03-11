# frozen_string_literal: true

require "rails_helper"

RSpec.describe "photos/edit" do
  let(:photo) { create :photo }

  before { assign :photo, photo }

  it { is_expected.to have_link href: photos_path }
  it { is_expected.to have_css "form[action='#{photo_path(photo)}'][method='post']" }

  context "with the form" do
    subject { page.find("form") }

    it { is_expected.to have_field "photo[alt]" }
    it { is_expected.to have_button "commit" }
  end
end
