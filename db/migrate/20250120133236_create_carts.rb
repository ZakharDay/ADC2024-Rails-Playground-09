class CreateCarts < ActiveRecord::Migration[7.2]
  def change
    create_table :carts do |t|
      t.string :cartable_type
      t.integer :cartable_id

      t.timestamps
    end
  end
end
