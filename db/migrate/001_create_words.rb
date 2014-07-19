class CreateWords < ActiveRecord::Migration
  def up
    create_table :words do |t|
      t.string   :word
      t.column   :data, :json
      t.datetime :defined_at
      t.timestamps
    end
    add_index :words, :word, unique: true
    add_index :words, :defined_at
  end

  def down
    drop_table :words
  end
end
