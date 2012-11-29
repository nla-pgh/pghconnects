class AddUserNameIndexToUsers < ActiveRecord::Migration
  def change
		add_column :users, :user_name, :string, :unique => true

		add_index :users, :user_name, :unique => true, :order => {:name => :desc}
  end
end
