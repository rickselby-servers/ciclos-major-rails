# frozen_string_literal: true

require "rails_helper"

RSpec.describe PartnerHelper do
  describe ".partner_modal_classes" do
    subject { helper.partner_modal_classes inline }

    [true, false].each do |inline|
      context "when inline is #{inline}" do
        let(:inline) { inline }

        it { is_expected.to be_an Array }
      end
    end
  end

  describe ".partner_modal_data" do
    subject { helper.partner_modal_data inline }

    [true, false].each do |inline|
      context "when inline is #{inline}" do
        let(:inline) { inline }

        it { is_expected.to be_a Hash }
      end
    end
  end
end
