class AddEndsAtToRounds < ActiveRecord::Migration[5.2]
  def change
    add_column :rounds, :ends_at, :datetime
  end
end
