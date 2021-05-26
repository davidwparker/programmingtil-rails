class AddSlugToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :slug, :string, index: true, unique: true
  end
end
