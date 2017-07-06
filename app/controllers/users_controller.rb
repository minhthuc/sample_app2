class UsersController < ApplicationController
  before_action :load_user, only: [:destroy, :show]
  before_action :logged_in_user, only: [:edit, :update, :show]
  before_action :correct_user, only: [:edit, :update]
  before_action :verify_admin!, only: :destroy

  def index
    @users = User.sort.paginate page: params[:page],
      per_page: Settings.user.per_page_size
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:success] = t "users.new.success"
      redirect_to root_path
    else
      flash.now[:warning] = t "user_signup.warning-signup"
      render :new
    end
  end

  def show
    return if @user
    render file: "public/404.html"
    redirect_to root_url && return unless @user.activated
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "users.edit.profile_update_sucess"
      redirect_to @user
    else
      flash.now[:warning] = t "users.edit.fail_update"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "users.user.destroy.deleted"
    else
      flash[:warning] = t "users.user.destroy.deny"
    end
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "sessions.create.please_log_in"
    redirect_to login_url
  end

  def correct_user
    @user = User.find_by id: params[:id]

    return if @user.current_user? current_user
    redirect_to root_url
  end

  def verify_admin!
    redirect_to root_path unless current_user.is_admin?
  end

  def load_user
    @user = User.find_by id: params[:id]

    return if @user
    render file: "public/404.html"
  end
end
