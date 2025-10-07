class CreateProperties < ActiveRecord::Migration[8.0]
  def change
    create_table :properties do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :location
      t.string :city
      t.string :country
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.decimal :price_per_night, precision: 10, scale: 2, null: false
      t.integer :property_type, default: 0
      t.integer :bedrooms
      t.integer :bathrooms
      t.integer :guests
      t.integer :status, default: 0
      t.boolean :featured, default: false
      t.integer :reviews_count, default: 0
      t.decimal :average_rating, precision: 3, scale: 2, default: 0.0

      t.timestamps
    end
    
    add_index :properties, :status
    add_index :properties, :featured
    add_index :properties, :property_type
    add_index :properties, [:city, :status]
    add_index :properties, :average_rating
  end
end
