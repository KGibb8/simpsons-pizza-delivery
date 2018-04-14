class CreateOrder < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.string :order_date
      t.boolean :is_beer
      t.string :address
      t.boolean :is_delivered, default: false
      t.boolean :is_cooked, default: false
    end
  end
end
