# == Schema Information
#
# Table name: contact_us
#
#  id         :bigint           not null, primary key
#  name       :string
#  email      :string
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ContactUs < ApplicationRecord
  include ContactUses::Hooks
  include ContactUses::Validations
end
