class TransferColumnsFromUsersToAddressesAndEducations < ActiveRecord::Migration
    def change
        add_column :addresses, :household_number, :integer
        add_column :addresses, :household_income, :float
        add_column :educations, :education_level, :string

        remove_column :users, :household_number
        remove_column :users, :household_income
        remove_column :users, :education_level
    end
end
