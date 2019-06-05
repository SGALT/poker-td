class CreateTournaments < ActiveRecord::Migration[5.2]
  def change
    create_table :tournaments do |t|
      t.string :title
      t.string :sub_title
      t.json :photos
      t.integer :attendees_nb
      t.integer :starting_stack
      t.string :color

      t.timestamps
    end
  end
end
