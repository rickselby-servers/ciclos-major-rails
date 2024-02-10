# frozen_string_literal: true

require "rails_helper"

RSpec.describe "home/show.html.erb" do
  subject { render }

  before do
    PageText.create key: "home.show.header", text: "header text"
  end

  it { is_expected.to include "header text" }
end
