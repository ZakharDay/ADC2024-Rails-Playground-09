class Gallery < ApplicationRecord
  has_many :gallery_images, -> { order(position: :asc) }, dependent: :delete_all
end
