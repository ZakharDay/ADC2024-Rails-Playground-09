class CommentsController < ApplicationController
	before_action :set_pin, only: [:create, :destroy ]

  def create
		@comment = @pin.comments.create(params[:comment].permit(:author, :content, :comment_id))
		redirect_to pin_path(@pin)
	end

	def destroy
		@comment = @pin.comments.find(params[:id])
		@comment.destroy
		redirect_to pin_path(@pin)
	end

  # def like
	# 	@comment = Comment.find(params[:id])
  #   likes = @comment.likes.where(user_id: current_user.id)

  #   if likes.count > 0
  #     likes.each do |like|
  #       like.destroy!
  #     end
  #   else
  #     @comment.likes.create(user_id: current_user.id)
  #   end

  #   redirect_to @comment.pin
  # end

	private

		def set_pin
			@pin = Pin.find(params[:pin_id])
		end

end
