# frozen_string_literal: true

require "rails_helper"

RSpec.describe "bike_rentals/new" do
  let(:bike_rental) { BikeRental.new }

  before { assign :bike_rental, bike_rental }

  it { is_expected.to have_link href: bike_rentals_path }
  it { is_expected.to have_css "form[action='#{bike_rentals_path}'][method='post']" }

  context "with the form" do
    subject { page.find("form") }

    it { is_expected.to have_field "bike_rental[name]" }
    it { is_expected.to have_field "bike_rental[description]" }
    it { is_expected.to have_field "bike_rental[photo]" }
    it { is_expected.to have_button "Add another detail" }
    it { is_expected.to have_button "Add another price" }
    it { is_expected.to have_button "commit" }
  end
end
