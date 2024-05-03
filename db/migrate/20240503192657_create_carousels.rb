# frozen_string_literal: true

class CreateCarousels < ActiveRecord::Migration[7.1]
  def change
    create_table :carousels do |t|
      t.string :reference

      t.timestamps
    end
  end
end
