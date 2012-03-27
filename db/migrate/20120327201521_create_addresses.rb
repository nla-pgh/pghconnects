class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
			t.integer		:number, :null => false
			t.string		:street, :null => false
			t.string		:apt_fl
			t.string		:city,		:null => false
			t.string		:state,		:null	=> false
			t.string		:zip,			:null	=> false

      t.timestamps
    end
  end
end
