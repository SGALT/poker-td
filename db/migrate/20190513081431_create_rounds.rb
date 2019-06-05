class CreateRounds < ActiveRecord::Migration[5.2]
  def change
    create_table :rounds do |t|
      t.references :tournament, foreign_key: true
      t.integer :order_nb
      t.integer :small_blind
      t.integer :big_blind
      t.integer :ante
      t.time :duration
      t.integer :state
      t.string :type

      t.timestamps
    end
  end
end
