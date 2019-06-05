class AddRemainingToTournaments < ActiveRecord::Migration[5.2]
  def change
    add_column :tournaments, :remaining_attendees, :integer
  end
end
