# frozen_string_literal: true

require "rails_helper"

RSpec.describe "photos/new" do
  let(:photo) { Photo.new }

  before { assign :photo, photo }

  it { is_expected.to have_link href: photos_path }
  it { is_expected.to have_css "form[action='#{photos_path}'][method='post']" }

  context "with the form" do
    subject { page.find("form") }

    it { is_expected.to have_field "photo[alt]" }
    it { is_expected.to have_button "commit" }
  end
end
