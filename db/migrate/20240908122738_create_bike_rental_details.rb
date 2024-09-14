# frozen_string_literal: true

class CreateBikeRentalDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :bike_rental_details do |t|
      t.references :bike_rental
      t.string :key
      t.string :value
      t.integer :position

      t.timestamps
    end
  end
end
