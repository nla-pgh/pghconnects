class AddUserIdToWorkHistories < ActiveRecord::Migration
  def change
		add_column :work_histories, :user_id, :integer
  end
end
