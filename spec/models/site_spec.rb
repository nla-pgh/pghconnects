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
#

require 'spec_helper'

describe "Sites" do
	let(:site) { factory_site(nil, nil) }
	subject { site }

	it { should respond_to(:name) }
	it { should respond_to(:address) }
	it { should respond_to(:phone) }

	it { should be_valid }

	describe "invalid attributes:" do
		context "blank" do
			context "name" do
				let(:site) { factory_site(:name, ' ') }
				it { should_not be_valid }
			end

			context "address" do
				let(:site) { factory_site(:address, ' ') }
				it { should_not be_valid }
			end

			context "phone" do
				let(:site) { factory_site(:phone, ' ') }
				it { should_not be_valid }
			end
		end
		
		context "wrong phone format" do
			let(:site) { factory_site(:phone, '4121234556') }
			it { should_not be_valid }
		end

	end
end
