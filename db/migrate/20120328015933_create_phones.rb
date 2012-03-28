class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
        t.string    :area
        t.string    :carrier
        t.string    :line

      t.timestamps
    end
  end
end
