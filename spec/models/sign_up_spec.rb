# == Schema Information
#
# Table name: sign_ups
#
#  id         :integer         not null, primary key
#  attended   :boolean         default(FALSE), not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  event_id   :integer
#  user_id    :integer
#

require 'spec_helper'

describe "SignUps" do
	subject { signup }

    before do
        @base_attrs = { :attended => false }
    end

    describe "sanity check" do
        let(:signup) { factory(:sign_up, @base_attrs, nil) }
        it { should be_valid }

        it { should respond_to(:attended) }

        describe "relationships" do
            it { should respond_to(:event) }
            context "with corrected structure" do
                it { should respond_to(:event_id) }
                it { should respond_to(:user_id) }
            end
        end
    end

	describe "invalid attributes:" do
		context "blank" do
			context "attended" do
				let(:signup) { factory(:sign_up, @base_attrs, :attended => nil) }
				it { should_not be_valid }
			end
		end
	end
end
