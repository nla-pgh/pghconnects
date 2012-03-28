# == Schema Information
#
# Table name: events
#
#  id          :integer         not null, primary key
#  name        :string(255)     not null
#  start       :datetime        not null
#  end         :datetime        not null
#  description :text            not null
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'spec_helper'

describe "Events" do
	let(:event) { factory_event(nil, nil) }
	subject { event }

	it { should respond_to(:name) }
	it { should respond_to(:start) }
	it { should respond_to(:end) }
	it { should respond_to(:description) }

	it { should be_valid }

	describe "relationships" do
		it { should respond_to(:sites) }
		it { should respond_to(:sign_ups) }
		it { should respond_to(:attendents) }
		it { should respond_to(:users) }
	end

	describe "invalid attributes:" do
		context "blank" do
			context "name" do
				let(:event) { factory_event(:name, ' ') }
				it { should_not be_valid }
			end

			context "start" do
				let(:event) { factory_event(:start, nil) }
				it { should_not be_valid }
			end

			context "end" do
				let(:event) { factory_event(:end, nil) }
				it { should_not be_valid }
			end

			context "description" do
				let(:event) { factory_event(:description, ' ') }
				it { should_not be_valid }
			end
		end
	end
end
