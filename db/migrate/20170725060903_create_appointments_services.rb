class CreateAppointmentsServices < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments_services do |t|
      t.belongs_to :appointment
      t.belongs_to :services
      t.timestamps
    end
  end
end
