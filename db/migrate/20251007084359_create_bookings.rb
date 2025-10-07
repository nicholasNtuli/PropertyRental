class CreateBookings < ActiveRecord::Migration[8.0]
  def change
    create_table :bookings do |t|
      t.references :property, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.date :check_in, null: false
      t.date :check_out, null: false
      t.decimal :total_price, precision: 10, scale: 2, null: false
      t.integer :status, default: 0
      t.integer :guests_count
      t.text :special_requests

      t.timestamps
    end

    add_index :bookings, :status
    add_index :bookings, [:property_id, :check_in, :check_out]
  end
end
