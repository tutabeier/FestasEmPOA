class CreateCuckos < ActiveRecord::Migration
  def change
    create_table :cuckos do |t|
      t.string :name
      t.string :date
      t.string :hour
      t.string :link
      t.string :image
      t.integer :id_festa

      t.timestamps
    end
  end
end
