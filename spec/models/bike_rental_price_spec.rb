# frozen_string_literal: true

require "rails_helper"

RSpec.describe BikeRentalPrice do
  subject { build :bike_rental_price }

  it { is_expected.to validate_presence_of :days }
  it { is_expected.to validate_presence_of :total_price }
  it { is_expected.to validate_numericality_of :days }
  it { is_expected.to validate_numericality_of :total_price }
  it { is_expected.to validate_uniqueness_of(:days).scoped_to(:bike_rental_id) }

  it { is_expected.to be_audited }
  it { is_expected.to belong_to :bike_rental }

  describe "price_per_day" do
    let(:bike_rental_price) { create :bike_rental_price, days: 4, total_price: 99 }

    it "divides total price by days and includes pence/cents" do
      expect(bike_rental_price.price_per_day).to eq 24.75
    end
  end
end
