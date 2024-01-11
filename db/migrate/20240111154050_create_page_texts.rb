# frozen_string_literal: true

class CreatePageTexts < ActiveRecord::Migration[7.1]
  def change
    create_table :page_texts, id: false, primary_key: :key do |t|
      t.string :key
      t.text :all_text

      t.timestamps
    end
  end
end
