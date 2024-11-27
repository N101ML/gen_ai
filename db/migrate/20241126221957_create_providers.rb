class CreateProviders < ActiveRecord::Migration[7.1]
  def change
    create_table :providers do |t|
      t.string :name, null: false
      t.string :api_type, null: false

      t.timestamps
    end
  end
end
