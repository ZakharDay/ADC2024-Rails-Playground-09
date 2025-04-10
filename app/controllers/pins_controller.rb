class PinsController < ApplicationController
  before_action :set_pin, only: %i[ show edit update destroy ]

  # GET /pins or /pins.json
  def index
    @pins = Pin.all
  end

  def by_tag
    @pins = Pin.tagged_with(params[:tag])
    render :index
  end

  # GET /pins/1 or /pins/1.json
  def show
  end

  # GET /pins/new
  def new
    @pin = Pin.new
  end

  # GET /pins/1/edit
  def edit
  end

  # POST /pins or /pins.json
  def create
    @pin = Pin.new(pin_params)

    respond_to do |format|
      if @pin.save

        if current_user.pins.count == 1
          UserMailer.with(user: current_user).welcome_email.deliver_now
        end

        format.html { redirect_to pin_url(@pin), notice: "Pin was successfully created." }
        format.json { render :show, status: :created, location: @pin }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pins/1 or /pins/1.json
  def update
    respond_to do |format|
      if @pin.update(pin_params)
        format.html { redirect_to pin_url(@pin), notice: "Pin was successfully updated." }
        format.json { render :show, status: :ok, location: @pin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pins/1 or /pins/1.json
  def destroy
    @pin.destroy!

    respond_to do |format|
      format.html { redirect_to pins_url, notice: "Pin was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # def like
  #   likes = @pin.likes.where(user_id: current_user.id)

  #   if likes.count > 0
  #     likes.each do |like|
  #       like.destroy!
  #     end
  #   else
  #     @pin.likes.create(user_id: current_user.id)
  #   end

  #   redirect_to @pin
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pin
      @pin = Pin.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pin_params
      params.require(:pin).permit(:title, :description, :pin_image, :pin_teaser_image, :tag_list).merge(user_id: current_user.id)
    end
    
end
