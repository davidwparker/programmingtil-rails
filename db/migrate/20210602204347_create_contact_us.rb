class CreateContactUs < ActiveRecord::Migration[6.1]
  def change
    create_table :contact_us do |t|
      t.string :name
      t.string :email
      t.text :body
      t.timestamps null: false
    end
  end
end
