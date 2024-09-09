# frozen_string_literal: true

class CreateBikeRentalPrices < ActiveRecord::Migration[7.1]
  def change
    create_table :bike_rental_prices do |t|
      t.references :bike_rental
      t.integer :days, limit: 1, null: false
      t.integer :total_price, limit: 2, null: false

      t.timestamps

      t.index %i[bike_rental_id days], unique: true
    end
  end
end
