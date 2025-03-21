class GalleryImage < ApplicationRecord
  belongs_to :gallery
  # acts_as_list scope: :gallery
  mount_uploader :image, GalleryImageUploader

  default_scope { order(position: :asc) }

  after_create :set_orientation

  def set_orientation
    if image.width > image.height
      self.orientation = "landscape"
    elsif image.width < image.height
      self.orientation = "portrait"
    elsif image.width == image.height
      self.orientation = "square"
    else
      puts "ERROR"
    end

    self.save!
  end
end
