class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.datetime :date_time, null: false
      t.datetime :end_time
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone_number, null: false
      t.integer :staff_id, null: false
      t.integer :user_id
      t.belongs_to :store
      t.timestamps
    end
  end
end
