class CreateMicroposts < ActiveRecord::Migration[5.0]
  def change
    create_table :microposts do |t|
      t.text :title
      t.text :content
      t.integer :rank,              null: false, default: 0
      t.integer :purpose,              null: false, default: 1
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :microposts, [:user_id, :created_at, :rank]
  end
end
