class CreateStaffs < ActiveRecord::Migration[5.0]
  def change
    create_table :staffs do |t|
      t.string :name, null: false
      t.string :phone_number, null: false
      t.belongs_to :store, null: false
      t.timestamps
    end
  end
end
