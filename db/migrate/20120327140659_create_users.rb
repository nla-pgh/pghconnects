class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
			t.string			:first
			t.string			:middle
			t.string			:last
			t.date				:birth_date
			t.string			:registered_at
			t.string			:gender
			t.string			:ethnicity
			t.integer			:household_number
			t.float				:household_income
			t.primary_key	:id
			t.string			:education_level
			t.string			:clearance_level

      t.timestamps
    end
  end
end
