# frozen_string_literal: true

require "rails_helper"

RSpec.describe Carousel do
  it { is_expected.to validate_presence_of :reference }

  it { is_expected.to be_audited }
  it { is_expected.to have_many :photos }
end
