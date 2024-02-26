# frozen_string_literal: true

require "rails_helper"

RSpec.describe "guides/index" do
  let(:guide) { Guide.create! name: "Bob", description: "is person", photo: }
  let(:guide2) { Guide.create! name: "Bob", description: "is person", photo: }
  let(:photo) { Rack::Test::UploadedFile.new("spec/fixtures/example.jpg", "image/jpg") }

  before { assign(:guides, [guide, guide2]) }

  it { is_expected.to have_css "div > div > h2", text: "Bob", count: 2 }
  it { is_expected.to have_css "div > div", text: "is person", count: 2 }

  it { is_expected.to have_no_link href: new_guide_path }

  context "when logged in" do
    before { sign_in Admin.create }

    it { is_expected.to have_link href: new_guide_path }
  end
end
