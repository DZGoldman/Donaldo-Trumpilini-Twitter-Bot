class CreateMarkovs < ActiveRecord::Migration
  def change
    create_table :markovs do |t|
      
      t.timestamps null: false
    end
  end
end
