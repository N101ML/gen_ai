class CreateRenders < ActiveRecord::Migration[7.1]
  def change
    create_table :renders do |t|
      t.string :render_type
      t.float :guidance_scale
      t.integer :steps
      t.integer :num_outputs
      t.text :prompt, null: false
      t.integer :status, default: 0
      t.references :modelable, polymorphic: true, null: false

      t.timestamps
    end

     add_index :renders, [:modelable_type, :modelable_id], name: "index_renders_on_modelable_type_and_modelable_id"
  end
end
