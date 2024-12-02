class Pin < ApplicationRecord
  has_many :comments
  has_many :likes, as: :likeable

  mount_uploader :pin_image, PinImageUploader
  mount_uploader :pin_teaser_image, PinTeaserImageUploader

  acts_as_taggable_on :tags

  validates :title, presence: true
  validates :description, presence: true
end
