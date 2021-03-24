# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string
#  display_name           :string
#  slug                   :string
#  theme                  :integer          default(0)
#  theme_color            :integer          default(0)
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  include Users::Allowlist

  devise :database_authenticatable,
    :confirmable,
    :registerable,
    :recoverable,
    :rememberable,
    :validatable,
    :jwt_authenticatable,
    jwt_revocation_strategy: self

  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false }
  validates :username,
    presence: true,
    length: { minimum: 2 },
    uniqueness: { case_sensitive: false }

  # DEVISE-specific things
  # Devise override for logging in with username or email
  attr_writer :login

  def login
    @login || username || email
  end

  # Use :login for searching username and email
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where([
      "lower(username) = :value OR lower(email) = :value",
      { value: login.strip.downcase },
    ]).first
  end

  def for_display
    {
      email: email,
      id: id,
    }
  end
end
