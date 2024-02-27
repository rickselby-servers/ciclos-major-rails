# frozen_string_literal: true

# Helpers for request spec tests
module AuthHelpers
  shared_context "when logged in" do
    before { sign_in create :admin }
  end
end
