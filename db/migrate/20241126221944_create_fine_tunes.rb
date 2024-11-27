class CreateFineTunes < ActiveRecord::Migration[7.1]
  def change
    create_table :fine_tunes do |t|
      t.string :name
      t.references :base_model, null: false, foreign_key: true

      t.timestamps
    end
  end
end
