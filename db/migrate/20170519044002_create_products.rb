class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.string :type
      t.date :inward_date
      t.string :color

      t.timestamps
    end
  end
end
