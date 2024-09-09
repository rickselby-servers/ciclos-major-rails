# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/bike_rentals" do
  let(:bike_rental) { create :bike_rental }

  describe "GET /index" do
    subject do
      get bike_rentals_path
      response
    end

    it { is_expected.to be_successful }
  end

  describe "GET /new" do
    subject do
      get new_bike_rental_path
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it { is_expected.to be_successful }
    end
  end

  describe "GET /edit" do
    subject do
      get edit_bike_rental_path bike_rental
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it { is_expected.to be_successful }
    end
  end

  describe "POST /create" do
    subject(:do_post) do
      post bike_rentals_path, params: { bike_rental: attributes }
      response
    end

    let(:attributes) { attributes_for :bike_rental }

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      context "with valid parameters" do
        it "creates a new BikeRental" do
          expect { do_post }.to change(BikeRental, :count).by(1)
        end

        it { is_expected.to redirect_to bike_rentals_path }
      end

      context "with bike rental detail" do
        let(:attributes) { attributes_for :bike_rental, :with_detail_attributes }

        it "creates a new BikeRental" do
          expect { do_post }.to change(BikeRental, :count).by(1)
        end

        it "creates a new BikeRentalDetail" do
          expect { do_post }.to change(BikeRentalDetail, :count).by(1)
        end

        it { is_expected.to redirect_to bike_rentals_path }
      end

      context "with bike rental prices" do
        let(:attributes) { attributes_for :bike_rental, :with_price_attributes }

        it "creates a new BikeRental" do
          expect { do_post }.to change(BikeRental, :count).by(1)
        end

        it "creates a new BikeRentalPrice" do
          expect { do_post }.to change(BikeRentalPrice, :count).by(1)
        end

        it { is_expected.to redirect_to bike_rentals_path }
      end

      context "with invalid parameters" do
        let(:attributes) { attributes_for :bike_rental, :invalid }

        it "does not create a new BikeRental" do
          expect { do_post }.not_to change(BikeRental, :count)
        end

        it { is_expected.to have_http_status :unprocessable_entity }
      end
    end
  end

  describe "PATCH /update" do
    subject(:do_patch) do
      patch bike_rental_path(bike_rental), params: { bike_rental: new_attributes }
      response
    end

    let(:new_attributes) { attributes_for :bike_rental }

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      context "with valid parameters" do
        let(:expected_attributes) { new_attributes.except(:photo).transform_keys(&:to_s) }

        it "updates the requested bike_rental" do
          do_patch
          expect(bike_rental.reload.attributes.slice(*expected_attributes.keys)).to eq expected_attributes
        end

        it { is_expected.to redirect_to bike_rentals_path }
      end

      context "with bike rental detail" do
        let(:new_attributes) { attributes_for :bike_rental, :with_detail_attributes }

        it "creates a new BikeRentalDetail" do
          expect { do_patch }.to change(BikeRentalDetail, :count).by(1)
        end

        it { is_expected.to redirect_to bike_rentals_path }
      end

      context "with bike rental price" do
        let(:new_attributes) { attributes_for :bike_rental, :with_price_attributes }

        it "creates a new BikeRentalPrice" do
          expect { do_patch }.to change(BikeRentalPrice, :count).by(1)
        end

        it { is_expected.to redirect_to bike_rentals_path }
      end

      context "with invalid parameters" do
        let(:new_attributes) { attributes_for :bike_rental, :invalid }
        let(:expected_attributes) { bike_rental.attributes.transform_keys(&:to_s) }

        it "does not update the requested bike_rental" do
          do_patch
          expect(bike_rental.reload.attributes.slice(*expected_attributes.keys)).to eq expected_attributes
        end

        it { is_expected.to have_http_status :unprocessable_entity }
      end
    end
  end

  describe "PATCH /move" do
    subject(:do_move) do
      patch move_bike_rental_path bike_rental, from: 0, to: 1
      response
    end

    let!(:bike_rental) { create :bike_rental }
    let!(:bike_rental2) { create :bike_rental }

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it { is_expected.to be_ok }

      it "moves the first bike rental to position 1" do
        do_move
        expect(bike_rental.reload.position).to eq 1
      end

      it "moves the second bike rental to position 0" do
        do_move
        expect(bike_rental2.reload.position).to eq 0
      end
    end
  end

  describe "DELETE /destroy" do
    subject(:do_delete) do
      delete bike_rental_path(bike_rental)
      response
    end

    it_behaves_like "it redirects to login if not logged in"

    context "when logged in", :logged_in do
      it "destroys the requested bike_rental" do
        bike_rental # load the bike_rental before the check that we delete it
        expect { do_delete }.to change(BikeRental, :count).by(-1)
      end

      it { is_expected.to redirect_to bike_rentals_path }
    end
  end
end
