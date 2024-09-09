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
end
