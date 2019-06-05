class AddCategoryToRounds < ActiveRecord::Migration[5.2]
  def change
    add_column :rounds, :category, :string
  end
end
