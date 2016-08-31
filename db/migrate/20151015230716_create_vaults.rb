class CreateVaults < ActiveRecord::Migration
  def change
    create_table :vaults do |t|
      t.string :name
      t.text :readme
      t.integer :exposure, :limit => 1, default: 0
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
