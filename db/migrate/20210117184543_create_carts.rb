class CreateCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :carts do |t|
      t.string :item
      t.integer :quantity, default: 1
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
