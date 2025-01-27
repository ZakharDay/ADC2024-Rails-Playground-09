class Guest < ApplicationRecord
  has_many :carts, as: :cartable

  after_create :create_cart

  def create_cart
    Cart.create!(cartable_type: 'Guest', cartable_id: id)
  end
end
