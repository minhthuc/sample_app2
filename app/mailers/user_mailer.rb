class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: t("mailer.account_activation.usermailer.subject")
  end

  def password_reset
    @greeting = t "mailer.account_activation.view.hi"
    mail to: "to@example.org"
  end
end
