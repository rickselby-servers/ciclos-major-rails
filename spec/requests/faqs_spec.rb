# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/faqs" do
  let(:invalid_attributes) { { question: "", answer: "" } }
  let(:valid_attributes) { { question: "foo", answer: "bar" } }

  before(:each, :logged_in) do
    sign_in Admin.create
  end

  describe "GET /index" do
    it "renders a successful response" do
      Faq.create! valid_attributes
      get faqs_url
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    context "when not logged in" do
      it "redirects to the login page" do
        get new_faq_url
        expect(response).to redirect_to new_admin_session_path
      end
    end

    context "when logged in", :logged_in do
      it "renders a successful response" do
        get new_faq_url
        expect(response).to be_successful
      end
    end
  end

  describe "GET /edit" do
    context "when not logged in" do
      it "redirects to the login page" do
        faq = Faq.create! valid_attributes
        get edit_faq_url(faq)
        expect(response).to redirect_to new_admin_session_path
      end
    end

    context "when logged in", :logged_in do
      it "renders a successful response" do
        faq = Faq.create! valid_attributes
        get edit_faq_url(faq)
        expect(response).to be_successful
      end
    end
  end

  describe "POST /create" do
    context "when not logged in" do
      it "redirects to the login page" do
        post faqs_url, params: { faq: valid_attributes }
        expect(response).to redirect_to new_admin_session_path
      end
    end

    context "when logged in", :logged_in do
      context "with valid parameters" do
        it "creates a new Faq" do
          expect do
            post faqs_url, params: { faq: valid_attributes }
          end.to change(Faq, :count).by(1)
        end

        it "redirects to the created faq" do
          post faqs_url, params: { faq: valid_attributes }
          expect(response).to redirect_to(faqs_url)
        end
      end

      context "with invalid parameters" do
        it "does not create a new Faq" do
          expect do
            post faqs_url, params: { faq: invalid_attributes }
          end.not_to change(Faq, :count)
        end

        it "renders a response with 422 status (i.e. to display the 'new' template)" do
          post faqs_url, params: { faq: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end

  describe "PATCH /update" do
    let(:new_attributes) { { question: "bar", answer: "baz" } }

    context "when not logged in" do
      it "redirects to the login page" do
        faq = Faq.create! valid_attributes
        patch faq_url(faq), params: { faq: new_attributes }
        expect(response).to redirect_to new_admin_session_path
      end
    end

    context "when logged in", :logged_in do
      context "with valid parameters" do
        let(:new_attributes_string_keys) { new_attributes.transform_keys(&:to_s) }

        it "updates the requested faq" do
          faq = Faq.create! valid_attributes
          patch faq_url(faq), params: { faq: new_attributes }
          faq.reload
          expect(faq.attributes.slice(*new_attributes_string_keys.keys)).to eq new_attributes_string_keys
        end

        it "redirects to the faq" do
          faq = Faq.create! valid_attributes
          patch faq_url(faq), params: { faq: new_attributes }
          faq.reload
          expect(response).to redirect_to(faqs_path)
        end
      end

      context "with invalid parameters" do
        it "renders a response with 422 status (i.e. to display the 'edit' template)" do
          faq = Faq.create! valid_attributes
          patch faq_url(faq), params: { faq: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end

  describe "DELETE /destroy" do
    context "when not logged in" do
      it "redirects to the login page" do
        get new_faq_url
        expect(response).to redirect_to new_admin_session_path
      end
    end

    context "when logged in", :logged_in do
      it "destroys the requested faq" do
        faq = Faq.create! valid_attributes
        expect do
          delete faq_url(faq)
        end.to change(Faq, :count).by(-1)
      end

      it "redirects to the faqs list" do
        faq = Faq.create! valid_attributes
        delete faq_url(faq)
        expect(response).to redirect_to(faqs_url)
      end
    end
  end
end
