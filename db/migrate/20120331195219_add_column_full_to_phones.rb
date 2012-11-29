class AddColumnFullToPhones < ActiveRecord::Migration
  def change
      add_column :phones, :full, :string
  end
end
