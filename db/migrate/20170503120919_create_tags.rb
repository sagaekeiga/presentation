class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.text :name
      t.integer :frequency,              null: false, default: 0
      t.text :description,              null: false, default: ""

      t.timestamps
    end
    add_index :tags, [:name, :frequency]
  end
end
