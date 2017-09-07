class AddOtherToFoods < ActiveRecord::Migration[5.0]
  def change
    add_column :foods, :other, :boolean
  end
end
