class CreateAllowlistedJwts < ActiveRecord::Migration[6.1]
  def change
    create_table :allowlisted_jwts do |t|
      t.references :users, foreign_key: { on_delete: :cascade }, null: false
      t.string :jti, null: false
      t.string :aud, null: false
      t.datetime :exp, null: false
      t.string :remote_ip
      t.string :os_data
      t.string :browser_data
      t.string :device_data
      t.timestamps null: false
    end

    add_index :allowlisted_jwts, :jti, unique: true
  end
end
