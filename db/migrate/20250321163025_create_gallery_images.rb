class CreateGalleryImages < ActiveRecord::Migration[7.2]
  def change
    create_table :gallery_images do |t|
      t.integer :gallery_id
      t.string :image
      t.integer :position
      t.string :orientation

      t.timestamps
    end
  end
end
