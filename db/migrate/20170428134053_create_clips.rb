class CreateClips < ActiveRecord::Migration[5.0]
  def change
    create_table :clips do |t|
      t.integer :user_id
      t.integer :micropost_id

      t.timestamps
    end
    add_index :clips, :user_id
    add_index :clips, :micropost_id
    add_index :clips, [:user_id, :micropost_id], unique: true
  end
end
