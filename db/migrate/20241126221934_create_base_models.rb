class CreateBaseModels < ActiveRecord::Migration[7.1]
  def change
    create_table :base_models do |t|
      t.string :name, null: false
      t.string :company

      t.timestamps
    end
  end
end
