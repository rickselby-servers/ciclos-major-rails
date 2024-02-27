# frozen_string_literal: true

require "rails_helper"

RSpec.describe "guides/edit" do
  let(:guide) { create :guide }

  before { assign(:guide, guide) }

  it { is_expected.to have_link href: guides_path }
  it { is_expected.to have_css "form[action='#{guide_path(guide)}'][method='post']" }

  context "with the form" do
    subject { page.find("form") }

    it { is_expected.to have_field "guide[name]" }
    it { is_expected.to have_field "guide[description]" }
    it { is_expected.to have_field "guide[photo]" }
    it { is_expected.to have_button "commit" }
  end
end
