class ChangeCounterFromRounds < ActiveRecord::Migration[5.2]
  def change
    remove_column :rounds, :counter, :time
    add_column :rounds, :counter, :float
  end
end
