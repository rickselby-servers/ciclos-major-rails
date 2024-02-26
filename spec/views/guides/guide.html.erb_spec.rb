# frozen_string_literal: true

require "rails_helper"

RSpec.describe "guides/_guide" do
  let(:guide) { Guide.create! name: "Bob", description: "is person", photo: }
  let(:locals) { { guide: } }
  let(:photo) { file_fixture_upload("example.jpg") }

  it { is_expected.to have_content "Bob" }
  it { is_expected.to have_content "is person" }

  it { is_expected.to have_no_link href: edit_guide_path(guide) }

  context "with html" do
    let(:guide) { Guide.create! name: "Bob", description: "<strong>is person</strong>", photo: }

    it { is_expected.to have_css "strong", text: "is person" }
  end

  context "when logged in" do
    before { sign_in Admin.create }

    it { is_expected.to have_link href: edit_guide_path(guide) }
  end
end
