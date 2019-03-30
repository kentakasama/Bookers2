class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
  	@users = User.all
    @book = Book.new
  end

  def show
  	@user = User.find(params[:id])
  	@books = @user.book.all
    @book = Book.new
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path(user.id)
  end

  def edit
  	@user = User.find(current_user.id)
    @book = Book.new
  end
  private
  def user_params
    params.require(:user).permit(:name, :introduction, :user_image)
  end
end


