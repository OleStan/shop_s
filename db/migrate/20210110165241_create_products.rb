class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.float :price, precision:10, scale:2
      t.string :about
      t.string :config
      t.string :photo
      t.string :article
      t.string :factory
      t.string :product_name
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
