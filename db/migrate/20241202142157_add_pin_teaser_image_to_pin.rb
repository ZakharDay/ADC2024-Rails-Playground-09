class AddPinTeaserImageToPin < ActiveRecord::Migration[7.2]
  def change
    add_column :pins, :pin_teaser_image, :string
  end
end
