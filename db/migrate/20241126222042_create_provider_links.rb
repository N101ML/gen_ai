class CreateProviderLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :provider_links do |t|
      t.references :provider, null: false, foreign_key: true
      t.references :linkable, polymorphic: true, null: false
      t.string :view_link
      t.string :source_link

      t.timestamps
    end

    add_index :provider_links, [:linkable_type, :linkable_id], name: "index_provider_links_on_linkable_type_and_linkable_id"
  end
end
