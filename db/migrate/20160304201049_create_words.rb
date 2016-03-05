class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :word
      t.string :chain, array: true, default: []
      t.boolean :end, default: false

      t.timestamps null: false
    end
  end
end
