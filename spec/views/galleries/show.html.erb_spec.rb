# frozen_string_literal: true

require "rails_helper"

RSpec.describe "galleries/show" do
  let(:gallery) { create :gallery }

  before { assign :gallery, gallery }

  it { is_expected.to have_content gallery.name }

  it { is_expected.to have_no_link href: edit_gallery_path(gallery) }

  context "when logged in", :logged_in do
    it { is_expected.to have_link href: edit_gallery_path(gallery) }
  end
end
