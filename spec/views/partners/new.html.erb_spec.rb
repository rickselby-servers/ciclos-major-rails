# frozen_string_literal: true

require "rails_helper"

RSpec.describe "partners/new" do
  let(:partner) { Partner.new }

  before { assign :partner, partner }

  it { is_expected.to have_link href: partners_path }
  it { is_expected.to have_css "form[action='#{partners_path}'][method='post']" }

  context "with the form" do
    subject { page.find("form") }

    it { is_expected.to have_field "partner[name]" }
    it { is_expected.to have_field "partner[details]" }
    it { is_expected.to have_field "partner[url]" }
    it { is_expected.to have_field "partner[logo]" }
    it { is_expected.to have_button "commit" }
  end
end
