class CreateSentences < ActiveRecord::Migration
  def change
    create_table :sentences do |t|
      t.text :body

      t.timestamps null: false
    end
  end
end
