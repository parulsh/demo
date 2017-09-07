class AddOtherDietsToFoods < ActiveRecord::Migration[5.0]
  def change
    add_column :foods, :other_diets, :boolean
  end
end
