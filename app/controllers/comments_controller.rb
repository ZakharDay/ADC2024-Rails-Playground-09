class CommentsController < ApplicationController
	before_action :set_pin, only: [:edit, :create, :destroy]
	before_action :set_comment, only: [:show, :edit, :update]

	def show
	end

	def edit
  end

  def create
		# @comment = @pin.comments.create(params[:comment].permit(:author, :content, :comment_id))
		# redirect_to pin_path(@pin)

    @comment = @pin.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.turbo_stream
        format.html { redirect_to pin_comment_url(@comment.pin, @comment), notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
	end

	def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to pin_comment_url(@comment.pin, @comment), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
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

		def set_comment
			@comment = Comment.find(params[:id])
		end

    def comment_params
      params.require(:comment).permit(:author, :content, :pin_id, :comment_id)
    end

end
