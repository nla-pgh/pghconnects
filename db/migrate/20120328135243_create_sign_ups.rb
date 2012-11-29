class CreateSignUps < ActiveRecord::Migration
  def change
    create_table :sign_ups do |t|
      t.boolean :attended, :default => false

      t.timestamps
    end
  end
end
