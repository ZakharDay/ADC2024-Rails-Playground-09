class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_guest

  def authenticate_guest
    if current_user
      puts 'CURRENT USER'
      puts current_user.to_json

      if cookies[:guest_token]
        @guest = Guest.find_by_jti(cookies[:guest_token])

        if @guest
          @cart = @guest.carts.first

          if current_user.carts.any?
            if @cart.products.any?
              current_user.carts.first.destroy!
              @cart.update!(cartable_type: 'User', cartable_id: current_user.id)
            else
              @cart = current_user.carts.first
            end
          else
            @cart.update!(cartable_type: 'User', cartable_id: current_user.id)
          end

          @guest.destroy!
          cookies.delete(:guest_token)
        else
          if current_user.carts.any?
            @cart = current_user.carts.first
          else
            @cart = Cart.create!(cartable_type: 'User', cartable_id: current_user.id)
          end

          cookies.delete(:guest_token)
        end
      else
        if current_user.carts.any?
          @cart = current_user.carts.first
        else
          @cart = Cart.create!(cartable_type: 'User', cartable_id: current_user.id)
        end
      end
    else
      if cookies[:guest_token]
        jti = cookies[:guest_token]
        @guest = Guest.find_by_jti(jti)

        if @guest
          @cart = @guest.carts.last
        else
          cookies.delete(:guest_token)

          jti = SecureRandom.uuid
          @guest = Guest.create!(jti: jti)
          @cart = @guest.carts.last
          cookies[:guest_token] = jti
        end

        puts "GUEST TOKEN"
        puts jti
      else
        puts "NO TOKEN"
        jti = SecureRandom.uuid
        @guest = Guest.create!(jti: jti)
        @cart = @guest.carts.last
        cookies[:guest_token] = jti
      end
    end

    # cookies.delete(:guest_token)
  end

end
