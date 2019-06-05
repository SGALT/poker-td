class AddCounterToRounds < ActiveRecord::Migration[5.2]
  def change
    add_column :rounds, :counter, :time
  end
end
