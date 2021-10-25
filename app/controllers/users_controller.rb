class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])

    unless current_user.id == @user.id
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:success] = "You have updated user successfully."
    else
    @books = Book.all
      render :edit
    end
  end

  def index
    @users = User.all
    @book = Book.new
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end