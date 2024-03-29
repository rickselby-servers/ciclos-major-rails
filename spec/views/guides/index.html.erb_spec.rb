# frozen_string_literal: true

require "rails_helper"

RSpec.describe "guides/index" do
  let(:guide) { create :guide, name: "Bob", description: "is person" }
  let(:guide2) { create :guide, name: "Bob", description: "is person" }

  before { assign(:guides, [guide, guide2]) }

  it { is_expected.to have_css "div > div > h2", text: "Bob", count: 2 }
  it { is_expected.to have_css "div > div", text: "is person", count: 2 }

  it { is_expected.to have_no_link href: new_guide_path }

  context "when logged in", :logged_in do
    it { is_expected.to have_link href: new_guide_path }
  end
end
