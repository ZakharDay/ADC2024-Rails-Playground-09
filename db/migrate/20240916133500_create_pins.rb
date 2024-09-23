class CreatePins < ActiveRecord::Migration[7.2]
  def change
    create_table :pins do |t|
      t.string :title
      t.text :description
      t.string :pin_image

      t.timestamps
    end
  end
end
