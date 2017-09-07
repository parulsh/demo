class AddUserToFoods < ActiveRecord::Migration[5.0]
  def change
    add_reference :foods, :user, foreign_key: true
  end
end
