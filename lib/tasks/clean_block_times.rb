namespace :clean_block_times do
  desc "delete all the block times data one day before today"
  task clean: :environment do
    block_time_array = []
    Staff.all.each do |staff|
      block_time_array<<staff.block_times.where("start_time <= :one_hour_before",{one_hour_before: Time.zone.now - 1.hour})
    end

    block_time_array.flatten.each do |block_time|
      @block_time = block_time
      @block_time.destroy
    end
  end
end