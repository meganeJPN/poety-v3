class ContactMailer < ApplicationMailer
  def contact_mail(poeet)
    @poeet = poeet
    mail to: "ooosamuuu1985@gmail.com", subject: "新規ポイート"
  end
end
