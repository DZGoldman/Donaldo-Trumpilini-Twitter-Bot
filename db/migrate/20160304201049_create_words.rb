class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :word
      t.text :chain, array: true, default: []

      t.timestamps null: false
    end
  end
end
