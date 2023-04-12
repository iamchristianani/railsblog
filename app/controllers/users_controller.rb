class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.all.order(created_at: :asc)
    @current_user = current_user
  end

  def show
    @user = User.find(params[:id])
  end
end