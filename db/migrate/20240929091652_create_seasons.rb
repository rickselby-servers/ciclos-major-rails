# frozen_string_literal: true

class CreateSeasons < ActiveRecord::Migration[7.2]
  def change
    create_table :seasons do |t|
      t.string :name
      t.text :description
      t.date :start_date
      t.date :end_date
      t.date :launch_date
      t.boolean :sold_out, null: false, default: false

      t.timestamps
    end
  end
end
