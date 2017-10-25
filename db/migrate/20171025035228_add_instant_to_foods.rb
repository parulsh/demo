class AddInstantToFoods < ActiveRecord::Migration[5.0]
  def change
    add_column :foods, :instant, :integer, default: 1
  end
end
