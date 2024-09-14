# frozen_string_literal: true

require "rails_helper"

RSpec.describe BikeRentalDetail do
  it { is_expected.to validate_presence_of :key }
  it { is_expected.to validate_presence_of :value }

  it { is_expected.to be_audited }
  it { is_expected.to belong_to :bike_rental }
end
