class CreateFoods < ActiveRecord::Migration[5.0]
  def change
    create_table :foods do |t|
      t.string :cuisine_type
      t.string :entree_type
      t.integer :portions_available
      t.string :listing_name
      t.text :summary
      t.string :address
      t.boolean :organic
      t.boolean :vegan
      t.boolean :vegetarian
      t.boolean :gluten_free

      t.timestamps
    end
  end
end
