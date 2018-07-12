class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.integer :value
      t.references :post, index: true, foreign_key: true

      t.timestamps
    end
  end
end
