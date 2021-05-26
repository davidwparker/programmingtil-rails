class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :commentable, null: :false, polymorphic: true
      t.references :user, index: true
      t.references :thread, index: true
      t.references :parent, index: true
      t.text :body, null: false
      t.datetime :deleted_at
      t.timestamps null: false
    end

    add_column :posts, :comments_count, :bigint
  end
end
