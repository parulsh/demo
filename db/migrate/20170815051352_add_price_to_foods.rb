class AddPriceToFoods < ActiveRecord::Migration[5.0]
  def change
    add_column :foods, :price, :integer
  end
end
