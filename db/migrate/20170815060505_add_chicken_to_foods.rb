class AddChickenToFoods < ActiveRecord::Migration[5.0]
  def change
    add_column :foods, :chicken, :boolean
  end
end
