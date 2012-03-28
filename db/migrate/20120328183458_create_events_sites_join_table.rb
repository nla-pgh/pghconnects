class CreateEventsSitesJoinTable < ActiveRecord::Migration
	def change
		create_table :events_sites, :id => false do |t|
			t.integer :event_id
			t.integer :site_id
		end
	end
end
