class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      NewUserEmailMailer.notify_user(@user).deliver
      flash[:message] = "User successfully created."
      redirect_to user_path
    else
      flash.now[:error] = @user.errors.full_messages
      render :new
    end
  end

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to user_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :email)
  end
end
