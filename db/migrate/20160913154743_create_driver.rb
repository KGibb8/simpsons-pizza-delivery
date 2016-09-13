class CreateDriver < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
      t.string :name
      t.boolean :can_beer, default: false
      t.string :password_digest
    end
  end
end
