class CommentsController < ApplicationController
    protect_from_forgery :except => ["create"]
  
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      @micropost = @comment.micropost
      respond_to :js
    else
      flash[:alert] = "コメントに失敗しました"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @micropost = @comment.micropost
    if @comment.destroy
      respond_to :js
    else
      flash[:alert] = "コメントの削除に失敗しました"
    end
  end

  private
    def comment_params
      params.required(:comment).permit(:user_id, :micropost_id, :comment)
    end
end

