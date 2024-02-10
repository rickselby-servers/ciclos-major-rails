# frozen_string_literal: true

require "rails_helper"

RSpec.describe PageTextHelper, ".page_text_key" do
  subject { helper.page_text_key key }

  around do |example|
    @virtual_path = virtual_path
    example.run
    remove_instance_variable :@virtual_path
  end

  let(:key) { :index }
  let(:virtual_path) { "foo" }

  it { is_expected.to eq "foo.index" }

  context "with a path" do
    let(:virtual_path) { "foo/bar" }

    it { is_expected.to eq "foo.bar.index" }
  end

  context "with a path with underscores" do
    let(:virtual_path) { "foo/bar_thing" }

    it { is_expected.to eq "foo.bar_thing.index" }
  end

  context "with a path with a partial" do
    let(:virtual_path) { "foo/_partial" }

    it { is_expected.to eq "foo.partial.index" }
  end
end
