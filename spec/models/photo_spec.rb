# frozen_string_literal: true

require "rails_helper"

RSpec.describe Photo do
  it { is_expected.to validate_presence_of :photo }

  it { is_expected.to be_audited }
  it { is_expected.to belong_to :photoable }
  it { is_expected.to have_one_attached :photo }
end
