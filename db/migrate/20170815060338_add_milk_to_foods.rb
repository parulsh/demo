class AddMilkToFoods < ActiveRecord::Migration[5.0]
  def change
    add_column :foods, :milk, :boolean
  end
end
