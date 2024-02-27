# frozen_string_literal: true

require "rails_helper"

RSpec.describe "guides/_guide" do
  let(:guide) { create :guide }
  let(:locals) { { guide: } }

  it { is_expected.to have_content guide.name }
  it { is_expected.to have_content guide.description }

  it { is_expected.to have_no_link href: edit_guide_path(guide) }

  context "with html" do
    let(:guide) { create :guide, :html }

    it { is_expected.to have_css "strong", text: strip_tags(guide.description) }
  end

  context "when logged in", :logged_in do
    it { is_expected.to have_css ".sortable-handle" }
    it { is_expected.to have_link href: edit_guide_path(guide) }
  end
end
