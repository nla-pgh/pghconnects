class AddCorrectRelationshipIds < ActiveRecord::Migration
	def change
		add_column :emails, :user_id, :integer
		add_column :sign_ups, :event_id, :integer
		add_column :sign_ups, :user_id, :integer
		add_column :addresses, :user_id, :integer
		add_column :educations, :user_id, :integer
		add_column :phones, :user_id, :integer
		add_column :users, :site_id, :integer
	end
end
