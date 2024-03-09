# frozen_string_literal: true

require "rails_helper"

RSpec.describe "galleries/edit" do
  let(:gallery) { create :gallery }

  before { assign :gallery, gallery }

  it { is_expected.to have_link href: galleries_path }
  it { is_expected.to have_css "form[action='#{gallery_path(gallery)}'][method='post']" }

  context "with the form" do
    subject { page.find("form") }

    it { is_expected.to have_field "gallery[name]" }
    # it { is_expected.to have_field "gallery[photos]" }
    it { is_expected.to have_button "commit" }
  end
end
