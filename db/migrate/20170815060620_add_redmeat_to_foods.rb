class AddRedmeatToFoods < ActiveRecord::Migration[5.0]
  def change
    add_column :foods, :redmeat, :boolean
  end
end
