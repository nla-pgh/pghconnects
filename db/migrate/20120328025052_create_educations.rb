class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.text :institution
      t.text :focus
      t.string :credential
      t.string :school_id
      t.date :finish_on

      t.timestamps
    end
  end
end
