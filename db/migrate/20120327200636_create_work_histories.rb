class CreateWorkHistories < ActiveRecord::Migration
  def change
    create_table :work_histories do |t|
			t.string 	:business
			t.date		:start
			t.date		:end
			t.text		:description
			t.string	:title

      t.timestamps
    end
  end
end
