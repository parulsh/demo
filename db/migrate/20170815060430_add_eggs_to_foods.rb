class AddEggsToFoods < ActiveRecord::Migration[5.0]
  def change
    add_column :foods, :eggs, :boolean
  end
end
