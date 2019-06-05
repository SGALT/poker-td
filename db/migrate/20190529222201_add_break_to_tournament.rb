class AddBreakToTournament < ActiveRecord::Migration[5.2]
  def change
    add_column :tournaments, :next_break, :datetime
  end
end
