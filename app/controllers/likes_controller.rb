class LikesController < ApplicationController
  def create
    @like = Like.create(user_id: current_user.id, micropost_id: params[:micropost_id])
    @likes = Like.where(micropost_id: params[:micropost_id])
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, micropost_id: params[:micropost_id])
    like.destroy
    @likes = Like.where(micropost_id: params[:micropost_id])
  end
end