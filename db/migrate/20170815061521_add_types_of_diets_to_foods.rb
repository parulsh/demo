class AddTypesOfDietsToFoods < ActiveRecord::Migration[5.0]
  def change
    add_column :foods, :types_of_diets, :string
  end
end
