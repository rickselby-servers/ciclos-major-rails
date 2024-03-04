# frozen_string_literal: true

require "rails_helper"

RSpec.describe "admin/index", :logged_in do
  it { is_expected.to have_text "Admin Section" }

  it { is_expected.to have_link href: partners_path }
end
