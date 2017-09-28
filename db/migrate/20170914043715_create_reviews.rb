class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.integer :star, default: 1
      t.references :food, foreign_key: true
      t.references :order, foreign_key: true
      t.references :chef, foreign_key: true
      t.references :foodie, foreign_key: true
      t.string :type

      t.timestamps
    end
  end
end
