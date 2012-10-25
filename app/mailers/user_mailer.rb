class UserMailer < ActionMailer::Base
  default from: "no-reply@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.assignment.subject
  #
  def assignment(member, secret)
    @group = member.group
    @member = member
    @secret = secret

    mail to: member.user.email
  end
end
