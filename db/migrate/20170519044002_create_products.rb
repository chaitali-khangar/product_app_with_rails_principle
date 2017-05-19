class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.float :price, :precision => 8, :scale => 2
      t.string :type
      t.date :inward_date
      t.string :color

      t.timestamps
    end
  end
end
