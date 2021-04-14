class AddSlugToUsers < ActiveRecord::Migration[6.1]
  def change
    add_index :users, :slug, unique: true
  end
end
