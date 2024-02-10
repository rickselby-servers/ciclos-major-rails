# frozen_string_literal: true

require "rails_helper"

RSpec.describe PageText do
  it { is_expected.to validate_presence_of :key }
  it { is_expected.to validate_uniqueness_of :key }

  it { is_expected.to be_audited }
end
