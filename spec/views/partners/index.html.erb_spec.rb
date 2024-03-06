# frozen_string_literal: true

require "rails_helper"

RSpec.describe "partners/index", :logged_in do
  let(:attributes) { { name: "Name", url: "Url" } }

  let(:partner) { create :partner, **attributes }
  let(:partner2) { create :partner, **attributes }

  before { assign(:partners, [partner, partner2]) }

  it { is_expected.to have_css "table td", text: "Name", count: 2 }
  it { is_expected.to have_css "table td", text: "Url", count: 2 }

  it { is_expected.to have_link href: new_partner_path }
end
