class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      t.references :category, null: false, foreign_key: true
      t.string :title
      t.references :user, null: false, foreign_key: true
      t.text :description
      t.integer :price

      t.timestamps
    end
  end
end
