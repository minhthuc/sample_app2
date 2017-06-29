class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:success] = t "user_signup.success-signup"
      redirect_to @user
    else
      flash.now[:warning] = t "user_signup.warning-signup"
      render :new
    end
  end

  def show
    @user = User.find_by id: params[:id]
    return if @user
    render file: "public/404.html"
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
