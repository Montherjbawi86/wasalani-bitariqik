class CreateRides < ActiveRecord::Migration[7.1]
  def change
    create_table :rides do |t|
      t.references :driver, null: false, foreign_key: { to_table: :users }
      t.string :from_city
      t.string :to_city
      t.datetime :departure_time
      t.integer :available_seats
      t.decimal :price
      t.text :notes

      t.timestamps
    end
  end
end
