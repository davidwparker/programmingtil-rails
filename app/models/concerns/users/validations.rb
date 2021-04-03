module Users::Validations
  extend ActiveSupport::Concern

  included do
    validates :email,
      presence: true,
      uniqueness: { case_sensitive: false }
    validates :username,
      presence: true,
      length: { minimum: 2 },
      uniqueness: { case_sensitive: false }
  end
end
