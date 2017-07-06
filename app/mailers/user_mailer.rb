class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("mailer.account_activation.usermailer.subject")
  end

  def password_reset user
    @user = user
    mail to: user.email,
      subject: t("mailer.password_reset.usermailer.ps_reset")
  end
end
