# == Schema Information
#
# Table name: sign_ups
#
#  id         :integer         not null, primary key
#  attended   :boolean         default(FALSE), not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe "SignUps" do
	let(:signup) { factory_signup(nil, nil) }
	subject { signup }

	it { should respond_to(:attended) }
	
	it { should be_valid }

	describe "invalid attributes:" do
		context "blank" do
			context "attended" do
				let(:signup) { factory_signup(:attended, nil) }
				it { should_not be_valid }
			end
		end
	end
end
