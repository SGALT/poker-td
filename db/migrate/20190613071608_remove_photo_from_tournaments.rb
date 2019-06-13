class RemovePhotoFromTournaments < ActiveRecord::Migration[5.2]
  def change
    remove_column :tournaments, :photo, :string
  end
end
