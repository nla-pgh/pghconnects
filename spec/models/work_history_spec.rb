# == Schema Information
#
# Table name: work_histories
#
#  id          :integer         not null, primary key
#  business    :string(255)
#  start       :date
#  end         :date
#  description :text
#  title       :string(255)
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  user_id     :integer
#

require 'spec_helper'

describe "WorkHistories" do

	let (:wh) { WorkHistory.new }
	subject { wh }

	it { should respond_to(:business) }
	it { should respond_to(:start) }
	it { should respond_to(:end) }
	it { should respond_to(:description) }
	it { should respond_to(:title) }

	describe "relationships" do
		it { should respond_to(:user) }
		
		context "with correct structure" do
			it { should respond_to(:user_id) }
		end
	end
end
