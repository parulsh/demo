class AddActiveToFoods < ActiveRecord::Migration[5.0]
  def change
    add_column :foods, :active, :boolean
  end
end
