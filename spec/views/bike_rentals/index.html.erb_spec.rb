# frozen_string_literal: true

require "rails_helper"

RSpec.describe "bike_rentals/index" do
  let(:attributes) { { name: "Genesis", description: "is bike" } }
  let(:bike_rental) { create :bike_rental, **attributes }
  let(:bike_rental2) { create :bike_rental, **attributes }

  before { assign(:bike_rentals, [bike_rental, bike_rental2]) }

  it { is_expected.to have_css "div > div > h2", text: "Genesis", count: 2 }
  it { is_expected.to have_css "div > div > p", text: "is bike", count: 2 }

  it { is_expected.to have_no_link href: new_bike_rental_path }

  context "when logged in", :logged_in do
    it { is_expected.to have_link href: new_bike_rental_path }
  end
end
