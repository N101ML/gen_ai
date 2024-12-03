class AddLogoUrlToProvidersTable < ActiveRecord::Migration[7.1]
  def change
    add_column :providers, :logo_url, :string
  end
end
