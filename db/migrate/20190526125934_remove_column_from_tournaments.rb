class RemoveColumnFromTournaments < ActiveRecord::Migration[5.2]
  def change
    remove_column :tournaments, :photos, :json
    add_column :tournaments, :photo, :string
    add_column :tournaments, :photo_opt, :string
  end
end
