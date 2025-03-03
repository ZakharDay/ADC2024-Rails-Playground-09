class Pin < ApplicationRecord
  has_many :comments
  has_many :likes, as: :likeable
  belongs_to :user

  mount_uploader :pin_image, PinImageUploader
  mount_uploader :pin_teaser_image, PinTeaserImageUploader

  acts_as_taggable_on :tags

  validates :title, presence: true
  validates :description, presence: true

  has_rich_text :description

  default_scope { order(created_at: "DESC") }
end
