class AddPositionToFaqs < ActiveRecord::Migration[7.1]
  def change
    add_column :faqs, :position, :integer
  end
end
