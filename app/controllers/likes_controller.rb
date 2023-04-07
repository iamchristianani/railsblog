class LikesController < ApplicationController
  def create
    @like = current_user.likes.new
    @like.post_id = params[:post_id]
    @like.save
    flash[:success] = 'Liked successfully!'
    redirect_to "/users/#{current_user.id}/posts/#{params[:post_id]}"
  end
end
