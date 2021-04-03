class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, index: true
      t.string :title, null: false
      t.text :content, null: false
      t.timestamp :published_at
      t.timestamps
    end
  end
end
