class PostsController < ApplicationController
  def index
    @posts = Post.all
    @user = User.includes(:posts, :comments).find(params[:user_id])
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:success] = 'Post created successfully'
      redirect_to "/users/#{current_user.id}/posts"
    else
      flash[:danger] = "Couldn't create post"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    flash[:success] = 'Post successfully deleted'
    redirect_to "/users/#{current_user.id}/posts"
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
