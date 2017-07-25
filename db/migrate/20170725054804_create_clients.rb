class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :name, null: false
      t.string :phone_number, null: false
      t.timestamps
    end
  end
end
