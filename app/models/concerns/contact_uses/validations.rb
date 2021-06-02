module ContactUses::Validations
  extend ActiveSupport::Concern

  # Specs No
  included do
    # NOTE: different unicode for duplicates
    SPAMS = [
      "covid",
      "cryptocurrency",
      "сrуptоcurrеnсу",
      "dating",
      "dаting",
      "facebook",
      "lottery",
      "http://",
      "https://",
      "medical",
      "passive income",
      "passiveincome",
      "pharmacy",
      "pharmacyusa",
      "sendbulkmails",
      "sex dating",
      "sexy",
      "seху",
      "shipping",
      "stardatagroup",
      "surgical",
      "testosterone",
      "usd",
      "us-dollar",
    ].freeze

    validates :email,
      presence: true,
      length: { maximum: 255 },
      format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :body, presence: true
    validates :name, presence: true
    validate :check_for_spam

    def check_for_spam
      return unless name.present? && body.present?
      if SPAMS.any? { |s| name.downcase.include?(s) }
        errors.add(:name, 'Nope')
      end
      if SPAMS.any? { |s| body.downcase.include?(s) }
        errors.add(:body, 'Nope')
      end
    end
  end
end
