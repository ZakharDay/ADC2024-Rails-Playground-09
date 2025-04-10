class GalleryImagesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[ create destroy ]

  before_action :set_gallery_image, only: %i[ left right destroy ]
  before_action :set_gallery, only: %i[ left right destroy ]

  def create
    @gallery = Gallery.find(params[:gallery_id])
    @gallery_image = @gallery.gallery_images.new(gallery_image_params)

    respond_to do |format|
      if @gallery_image.save
        format.turbo_stream
      end
    end
  end

  def left
    if @gallery_image.move_higher
      respond_to do |format|
        @gallery_images = @gallery.gallery_images
        format.turbo_stream { render 'move' }
      end
    end
  end

  def right
    if @gallery_image.move_lower
      respond_to do |format|
        @gallery_images = @gallery.gallery_images
        format.turbo_stream { render 'move' }
      end
    end
  end

  def destroy
    @gallery = @gallery_image.gallery
    @gallery_image.destroy
  end

  private

    def set_gallery_image
      puts params
      @gallery_image = GalleryImage.find(params[:id])
    end

    def set_gallery
      @gallery = @gallery_image.gallery
    end

    def gallery_image_params
      params.require(:gallery_image).permit(:gallery_id, :image, :position)
    end

end
