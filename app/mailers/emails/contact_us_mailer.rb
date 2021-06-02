class Emails::ContactUsMailer < ApplicationMailer
  layout 'mailer'

  def contact(contact_us)
    headers = {
      subject: 'Contact us on ProgrammingTIL!',
      to: 'support@programmingtil.com',
      reply_to: 'no-reply@programmingtil.com',
    }
    @contact_us = contact_us
    mail(headers)
  end
end
