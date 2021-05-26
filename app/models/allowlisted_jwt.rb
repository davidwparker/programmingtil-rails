# == Schema Information
#
# Table name: allowlisted_jwts
#
#  id           :bigint           not null, primary key
#  user_id      :bigint           not null
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
#  index_allowlisted_jwts_on_jti      (jti) UNIQUE
#  index_allowlisted_jwts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id) ON DELETE => cascade
#
class AllowlistedJwt < ApplicationRecord
end
