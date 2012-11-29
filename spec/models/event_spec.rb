# == Schema Information
#
# Table name: events
#
#  id          :integer         not null, primary key
#  name        :string(255)     not null
#  start       :datetime        not null
#  end         :datetime        not null
#  description :text
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

require 'spec_helper'

describe "Events" do
	subject { event }

    before do
        @base_attrs = {
            :name => "Event",
            :start => DateTime.yesterday.midnight,
            :end => DateTime.now,
            :description => "A Event"
        }
    end

    describe "sanity check" do
        let(:event) { factory(:event, @base_attrs, nil) }
        it { should be_valid }

        it { should respond_to(:name) }
        it { should respond_to(:start) }
        it { should respond_to(:end) }
        it { should respond_to(:description) }


        describe "relationships" do
            it { should respond_to(:sites) }
            it { should respond_to(:sign_ups) }
            it { should respond_to(:attendents) }
            it { should respond_to(:users) }
        end
    end

	describe "invalid attributes:" do
		context "blank" do
			context "name" do
				let(:event) { factory(:event, @base_attrs, :name => ' ') }
				it { should_not be_valid }
			end

			context "start" do
				let(:event) { factory(:event, @base_attrs, :start => nil) }
				it { should_not be_valid }
			end

			context "end" do
				let(:event) { factory(:event, @base_attrs, :end => nil) }
				it { should_not be_valid }
			end
		end
	end
end
