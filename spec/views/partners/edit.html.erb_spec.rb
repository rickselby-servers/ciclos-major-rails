# frozen_string_literal: true

require "rails_helper"

RSpec.describe "partners/edit" do
  let(:partner) { create :partner }

  before { assign :partner, partner }

  it { is_expected.to have_link href: partners_path }
  it { is_expected.to have_css "form[action='#{partner_path(partner)}'][method='post']" }

  context "with the form" do
    subject { page.find("form") }

    it { is_expected.to have_field "partner[name]" }
    it { is_expected.to have_field "partner[details]" }
    it { is_expected.to have_field "partner[url]" }
    it { is_expected.to have_field "partner[logo]" }
    it { is_expected.to have_button "commit" }
  end
end
