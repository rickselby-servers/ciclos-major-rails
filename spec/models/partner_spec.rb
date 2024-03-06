# frozen_string_literal: true

require "rails_helper"

RSpec.describe Partner do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :details }
  it { is_expected.to validate_presence_of :url }
  it { is_expected.to validate_presence_of :logo }

  it { is_expected.to be_audited }
  it { is_expected.to have_one_attached :logo }
end
