class AddFontcolorToTournaments < ActiveRecord::Migration[5.2]
  def change
    add_column :tournaments, :font_color, :string
    remove_column :tournaments, :photo_opt, :string
  end
end
