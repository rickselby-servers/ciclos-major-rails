# frozen_string_literal: true

require "rails_helper"

RSpec.describe PageTextHelper, ".editable_text" do
  subject(:call_helper) { helper.editable_text key, classes: }

  around do |example|
    @virtual_path = "foo"
    example.run
    remove_instance_variable :@virtual_path
  end

  before do
    allow(mock_editable_text_helper).to receive(:html).and_return "html_output"
    allow(EditableTextHelper).to receive(:new).and_return mock_editable_text_helper
  end

  let(:classes)                   { %i[one two] }
  let(:key)                       { :index      }
  let(:mock_editable_text_helper) { double      }

  it { is_expected.to eq "html_output" }

  it "passes parameters as expected" do
    call_helper
    expect(EditableTextHelper).to have_received(:new).with(anything, "foo.index", classes:)
  end
end
