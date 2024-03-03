# frozen_string_literal: true

class CreateTestimonials < ActiveRecord::Migration[7.1]
  def change
    create_table :testimonials do |t|
      t.string :title
      t.text :text
      t.integer :position

      t.timestamps
    end
  end
end
