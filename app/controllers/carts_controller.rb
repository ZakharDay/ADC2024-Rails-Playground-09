class CartsController < ApplicationController

  def add
    @product = Product.find(params[:id])

    # if current_user
    #   @cart = current_user.carts.first
    # else
    #   @cart = @guest.carts.first
    # end

    @cart.products << @product

    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy
    if current_user
      current_user.carts.destroy_all
      current_user.carts.create!
    else
      # @guest = Guest.find_by_jti(cookies[:guest_token])
      @guest.carts.destroy_all
      @guest.carts.create!
    end

    respond_to do |format|
      format.turbo_stream
    end
  end

end
