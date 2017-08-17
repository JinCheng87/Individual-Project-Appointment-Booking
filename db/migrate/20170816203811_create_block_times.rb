class CreateBlockTimes < ActiveRecord::Migration[5.0]
  def change
    create_table :block_times do |t|
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.belongs_to :staff, null: false
      t.timestamps
    end
  end
end
