class GalleryImagesController < ApplicationController
  before_action :set_gallery_image, only: %i[ lower higher destroy ]
  before_action :set_gallery, only: %i[ lower higher destroy ]

  def create
    @gallery = Gallery.find(params[:gallery_id])
    @gallery_image = @gallery.gallery_images.new(gallery_image_params)

    respond_to do |format|
      if @gallery_image.save
        format.turbo_stream
      end
    end
  end

  def higher
    @gallery_image.move_higher
    @gallery_images = @gallery.gallery_images

    respond_to do |format|
      format.turbo_stream { render 'move' }
    end
  end

  def lower
    @gallery_image.move_lower
    @gallery_images = @gallery.gallery_images

    respond_to do |format|
      format.turbo_stream { render 'move' }
    end
  end

  def destroy
    @gallery_image.destroy
  end

  private

    def set_gallery_image
      @gallery_image = GalleryImage.find(params[:id])
    end

    def set_gallery
      @gallery = @gallery_image.gallery
    end

    def gallery_image_params
      params.require(:gallery_image).permit(:gallery_id, :image, :position)
    end

end
