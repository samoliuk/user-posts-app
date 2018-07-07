class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.integer :value
      t.references :post, foreign_key: true, index: true

      t.timestamps
    end
  end
end
