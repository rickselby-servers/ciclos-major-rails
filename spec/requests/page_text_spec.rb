# frozen_string_literal: true

require "rails_helper"

RSpec.describe "PageTexts" do
  describe "PUT /update" do
    subject(:page_response) do
      put page_text_path page_text, { key => new_text }
      response
    end

    let(:key)       { :foo                        }
    let(:page_text) { PageText.create key:, text: }
    let(:new_text)  { "baz"                       }
    let(:text)      { "bar"                       }

    it { is_expected.to redirect_to new_admin_session_path }

    context "when logged in" do
      before { sign_in Admin.create }

      it { is_expected.to redirect_to root_path }

      it "updates the text" do
        page_response
        expect(page_text.reload.text).to eq new_text
      end
    end
  end
end
