class CreateCartsProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :carts_products do |t|
      t.integer :cart_id
      t.integer :product_id

      t.timestamps
    end
  end
end
