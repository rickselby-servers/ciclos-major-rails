# frozen_string_literal: true

shared_examples "it redirects to login if not logged in" do
  it { is_expected.to redirect_to new_admin_session_path }
end
