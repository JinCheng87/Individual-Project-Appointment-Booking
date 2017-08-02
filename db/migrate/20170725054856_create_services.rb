class CreateServices < ActiveRecord::Migration[5.0]
  def change
    create_table :services do |t|
      t.string :name, null: false
      t.string :duration, null: false
      t.string :category, null: false
      t.float :price, null: false
      t.string :description
      t.timestamps
    end
  end
end
