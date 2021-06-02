module ContactUses::Hooks
  extend ActiveSupport::Concern

  # Specs No
  included do
    before_validation :downcase_email
    after_create :send_admin_email

    def downcase_email
      self.email = email.downcase if email.present?
    end

    def send_admin_email
      Emails::ContactUsMailer.contact(self).deliver_later
    end
  end
end
