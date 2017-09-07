class AddDietsToFoods < ActiveRecord::Migration[5.0]
  def change
    add_column :foods, :diets, :string
  end
end
