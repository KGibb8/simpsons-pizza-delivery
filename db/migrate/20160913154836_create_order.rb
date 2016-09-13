class CreateOrder < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :driver, foreign_key: true
      t.string :order_date, default: Time.now
      t.boolean :is_beer
      t.string :address
      t.boolean :is_delivered, default: false
    end
  end
end
