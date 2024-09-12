# frozen_string_literal: true

require "rails_helper"

RSpec.describe "galleries/index" do
  let(:attributes) { { name: "Name" } }
  let(:gallery) { create :gallery, **attributes }
  let(:gallery2) { create :gallery, **attributes }

  before { assign(:galleries, [gallery, gallery2]) }

  it { is_expected.to have_css "div > div > a > h2", text: attributes[:name], count: 2 }

  it { is_expected.to have_no_link href: new_gallery_path }

  context "when logged in", :logged_in do
    it { is_expected.to have_link href: new_gallery_path }
  end
end
