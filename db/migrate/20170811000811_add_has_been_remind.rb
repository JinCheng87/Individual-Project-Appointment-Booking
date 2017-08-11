class AddHasBeenRemind < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :has_been_reminded, :boolean, :default => false
  end
end
