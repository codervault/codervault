class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.string :name
      t.integer :language, :limit => 2, default: 0
      t.text :code
      t.references :vault, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
