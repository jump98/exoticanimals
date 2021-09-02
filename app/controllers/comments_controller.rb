class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  
  def create
    comment = Comment.new(comment_params)
    if comment.save
      redirect_to comment.animal, flash: {
        success: ["コメントを投稿しました"]
      }
    else
      redirect_to comment.animal, flash: {
        # comment: comment,
        danger: comment.errors.full_messages
      }
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.user_id == current_user.id
    comment.destroy
    redirect_to comment.animal, flash: {
      success: ["コメントが削除されました"]
    }
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:animal_id, :comment).merge(user_id: current_user.id)
    end

    def set_current_user
      @current_user = User.find_by(id: session[:user_id])
    end

    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      unless @comment
        redirect_to comment.animal
      end
    end
end
