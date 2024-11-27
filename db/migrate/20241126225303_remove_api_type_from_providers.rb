class RemoveApiTypeFromProviders < ActiveRecord::Migration[7.1]
  def change
    remove_column :providers, :api_type, :string
  end
end
