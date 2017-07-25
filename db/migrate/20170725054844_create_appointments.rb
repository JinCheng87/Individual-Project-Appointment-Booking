class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.date :date, null: false
      t.time :time, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone_number, null: false
      t.belongs_to :client
      t.belongs_to :staff
      t.timestamps
    end
  end
end
