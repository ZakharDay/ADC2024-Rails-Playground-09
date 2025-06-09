class Api::V1::GalleryImagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  before_action :set_gallery_image, only: %i[ lower higher destroy ]
  before_action :set_gallery, only: %i[ lower higher destroy ]

  def create
    # gallery = Gallery.find(params[:gallery_id])
    # @gallery_image = gallery.gallery_images.new(gallery_image_params)

    # if @gallery_image.save
    #   respond_to do |format|
    #     format.html { template: :create, layout: false  }
    #   #   format.json
    #   end
    #   # render json: { url: gallery_image.image.url }, status: :ok

    #   # html = render_to_string(template: 'gallery_images/show', layout: false)
    #   # html = render_to_string(partial: 'gallery_images/gallery_image', layout: false)

    #   # render body: 'gallery_images/show'
    #   # render json: { html: html }

    # end

    # render partial: 'gallery_images/gallery_image', layout: false
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
