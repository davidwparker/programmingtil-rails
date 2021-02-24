# == Schema Information
#
# Table name: allowlisted_jwts
#
#  id           :bigint           not null, primary key
#  users_id     :bigint           not null
#  jti          :string           not null
#  aud          :string           not null
#  exp          :datetime         not null
#  remote_ip    :string
#  os_data      :string
#  browser_data :string
#  device_data  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_allowlisted_jwts_on_jti       (jti) UNIQUE
#  index_allowlisted_jwts_on_users_id  (users_id)
#
# Foreign Keys
#
#  fk_rails_...  (users_id => users.id) ON DELETE => cascade
#
class AllowlistedJwt < ApplicationRecord
end
