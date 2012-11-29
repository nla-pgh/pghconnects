class AddAdditionalColumnsToSites < ActiveRecord::Migration
  def change
      add_column :sites, :abbr, :string
      add_column :sites, :base_ip, :string
  end
end
