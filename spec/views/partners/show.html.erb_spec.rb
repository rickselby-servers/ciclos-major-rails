# frozen_string_literal: true

require "rails_helper"

RSpec.describe "partners/_partner" do
  let(:partner) { create :partner }
  let(:locals) { { partner: } }

  it { is_expected.to have_content partner.name }
  it { is_expected.to have_content partner.details }
  it { is_expected.to have_content partner.url }

  context "with html" do
    let(:partner) { create :partner, :html }

    it { is_expected.to have_css "strong", text: strip_tags(partner.details) }
  end
end
