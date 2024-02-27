# frozen_string_literal: true

require "rails_helper"

RSpec.describe "PageTexts" do
  describe "PUT /update" do
    subject(:page_response) do
      put page_text_path page_text, { page_text.key => new_text }
      response
    end

    let(:page_text) { create :page_text }
    let(:new_text) { "baz" }

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it { is_expected.to redirect_to root_path }

      it "updates the text" do
        page_response
        expect(page_text.reload.text).to eq new_text
      end
    end
  end
end
