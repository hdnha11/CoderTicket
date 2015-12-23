class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.references :ticket_type, index: true, foreign_key: true
      t.integer :quantity
      t.references :booking, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
