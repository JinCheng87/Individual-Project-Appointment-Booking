class CreateStores < ActiveRecord::Migration[5.0]
  def change
    create_table :stores do |t|
      t.string :name, null: false
      t.string :location, null: false
      t.string :hours, null: false
      t.string :description, null: false
      t.timestamps
    end
  end
end
