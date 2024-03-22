# frozen_string_literal: true

require "rails_helper"

RSpec.describe "photos/new" do
  let(:photo) { Photo.new }
  let(:target) { create :gallery }

  before do
    assign :photo, photo
    assign :target, target
  end

  it { is_expected.to have_css "form[action='#{photos_path}'][method='post']" }

  context "with the form" do
    subject { page.find("form") }

    # TODO: has photos field?
    it { is_expected.to have_button "commit" }
  end
end
