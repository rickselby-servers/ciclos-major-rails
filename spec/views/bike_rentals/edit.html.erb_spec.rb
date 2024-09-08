# frozen_string_literal: true

require "rails_helper"

RSpec.describe "bike_rentals/edit" do
  let(:bike_rental) { create :bike_rental }

  before { assign :bike_rental, bike_rental }

  it { is_expected.to have_link href: bike_rentals_path }
  it { is_expected.to have_css "form[action='#{bike_rental_path(bike_rental)}'][method='post']" }

  context "with the form" do
    subject { page.find("form") }

    it { is_expected.to have_field "bike_rental[name]" }
    it { is_expected.to have_field "bike_rental[description]" }
    it { is_expected.to have_field "bike_rental[photo]" }
    it { is_expected.to have_button "Add another detail" }
    it { is_expected.to have_button "commit" }
  end
end
