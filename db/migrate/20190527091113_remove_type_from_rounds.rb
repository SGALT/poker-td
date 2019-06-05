class RemoveTypeFromRounds < ActiveRecord::Migration[5.2]
  def change
    remove_column :rounds, :type, :string
  end
end
