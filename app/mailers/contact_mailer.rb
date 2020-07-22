class ContactMailer < ApplicationMailer
  def contact_mail(poeet)
    @poeet = poeet
    mail to: "ooosamuuu1985@gmail.com", subject: "お問い合わせの確認メール"
  end
end
