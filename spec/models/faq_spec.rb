# frozen_string_literal: true

require "rails_helper"

RSpec.describe Faq do
  it { is_expected.to validate_presence_of :question }
  it { is_expected.to validate_presence_of :answer }

  it { is_expected.to be_audited }
end
