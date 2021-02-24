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
end
