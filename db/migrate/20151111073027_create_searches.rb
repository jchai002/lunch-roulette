class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :lat
      t.string :long
      t.string :radius
      t.string :rating
      
      t.timestamps null: false
    end
  end
end
