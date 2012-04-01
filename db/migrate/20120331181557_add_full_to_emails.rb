class AddFullToEmails < ActiveRecord::Migration
  def change
      add_column :emails, :full, :string
  end
end
