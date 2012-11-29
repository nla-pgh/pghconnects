# == Schema Information
#
# Table name: sites
#
#  id         :integer         not null, primary key
#  name       :string(255)     not null
#  address    :string(255)     not null
#  phone      :string(255)     not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  abbr       :string(255)
#  base_ip    :string(255)
#

require 'spec_helper'

describe "Sites" do
	subject { site }

    before do
        @base_attrs = {
            :name => "Site Name",
            :address => "address",
            :phone => "1231231234",
            :abbr => "SN",
            :base_ip => "10.123"
        }
    end

    describe "sanity check" do
        let(:site) { factory(:site, @base_attrs, nil) }

        it { should respond_to(:name) }
        it { should respond_to(:address) }
        it { should respond_to(:phone) }
        it { should respond_to(:abbr) }
        it { should respond_to(:base_ip) }

        it { should be_valid }

        describe "relationships" do
            it { should respond_to(:users) }
            it { should respond_to(:events) }
            it { should respond_to(:manager) }
            it { should respond_to(:coordinators) }
        end
    end

	describe "invalid attributes:" do
		context "blank" do
			context "name" do
				let(:site) { factory(:site, @base_attrs, :name => ' ') }
				it { should_not be_valid }
			end

			context "address" do
				let(:site) { factory(:site, @base_attrs, :address => ' ') }
				it { should_not be_valid }
			end

			context "phone" do
				let(:site) { factory(:site, @base_attrs, :phone => ' ') }
				it { should_not be_valid }
			end
		end
	end
end
