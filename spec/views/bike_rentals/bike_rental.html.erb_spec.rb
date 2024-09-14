# frozen_string_literal: true

require "rails_helper"

RSpec.describe "bike_rentals/_bike_rental" do
  let(:bike_rental) { create :bike_rental, :with_detail, :with_prices, details_count: 1, prices_count: 1 }
  let(:locals) { { bike_rental: } }

  it { is_expected.to have_content bike_rental.name }
  it { is_expected.to have_content bike_rental.description }
  it { is_expected.to have_content bike_rental.bike_rental_details.first.key }
  it { is_expected.to have_content bike_rental.bike_rental_details.first.value }
  it { is_expected.to have_content bike_rental.bike_rental_prices.first.days }
  it { is_expected.to have_content number_to_currency bike_rental.bike_rental_prices.first.total_price }

  it { is_expected.to have_no_link href: edit_bike_rental_path(bike_rental) }

  context "with html" do
    let(:bike_rental) { create :bike_rental, :html }

    it { is_expected.to have_css "strong", text: strip_tags(bike_rental.description) }
  end

  context "when logged in", :logged_in do
    it { is_expected.to have_css ".sortable-handle" }
    it { is_expected.to have_link href: edit_bike_rental_path(bike_rental) }
  end
end
