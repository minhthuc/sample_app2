class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]

    if user && !user.activated? &&
      user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = t "mailer.account_activation.controller.acc_active"
      redirect_to user
    else
      flash[:danger] = t "mailer.account_activation.controller.invalid_link"
      redirect_to root_url
    end
  end
end
