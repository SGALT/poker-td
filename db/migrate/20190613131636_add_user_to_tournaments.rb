class AddUserToTournaments < ActiveRecord::Migration[5.2]
  def change
    add_reference :tournaments, :user, foreign_key: true
  end
end
