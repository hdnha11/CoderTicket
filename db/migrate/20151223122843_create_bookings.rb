class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :name
      t.string :email
      t.text :address
      t.decimal :total

      t.timestamps null: false
    end
  end
end
