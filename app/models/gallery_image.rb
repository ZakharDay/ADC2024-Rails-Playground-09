class GalleryImage < ApplicationRecord
  belongs_to :gallery
  # acts_as_list scope: :gallery
  mount_uploader :image, GalleryImageUploader

  default_scope { order(position: :asc) }

  after_create :set_orientation
  after_create :set_position
  after_destroy :update_position

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

  def set_position
    self.position = self.gallery.gallery_images.count - 1
    self.save!
  end

  def update_position
    self.gallery.gallery_images.each_with_index do |gallery_image, index|
      gallery_image.position = index
      gallery_image.save!
    end
  end

  def move_lower
    return if lower_item

    prev_gallery_image = self.gallery.gallery_images.find_by_position(self.position - 1)
    
    current_position = self.position
    previous_position = prev_gallery_image.position
    
    self.position = previous_position
    prev_gallery_image.position = current_position

    self.save!
    prev_gallery_image.save!
  end

  def move_higher
    return if higher_item

    next_gallery_image = self.gallery.gallery_images.find_by_position(self.position + 1)
    
    current_position = self.position
    next_position = next_gallery_image.position
    
    self.position = next_position
    next_gallery_image.position = current_position

    self.save!
    next_gallery_image.save!
  end

  def lower_item
    if self.position == 0
      return true
    else
      return false
    end
  end

  def higher_item
    if self.gallery.gallery_images.count - 1 == self.position
      return true
    else
      return false
    end
  end

end
