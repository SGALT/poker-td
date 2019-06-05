class ChangeColumnDurationFromRounds < ActiveRecord::Migration[5.2]
  def change
    remove_column  :rounds, :duration, :time
    add_column :rounds, :duration, :integer
  end
end
