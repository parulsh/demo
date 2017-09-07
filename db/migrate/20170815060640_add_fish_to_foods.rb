class AddFishToFoods < ActiveRecord::Migration[5.0]
  def change
    add_column :foods, :fish, :boolean
  end
end
