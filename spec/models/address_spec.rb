# == Schema Information
#
# Table name: addresses
#
#  id         :integer         not null, primary key
#  number     :integer         not null
#  street     :string(255)     not null
#  apt_fl     :string(255)
#  city       :string(255)     not null
#  state      :string(255)     not null
#  zip        :string(255)     not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe "Addresses" do
	let (:address) { Address.new }
	subject { address }

	it { should respond_to(:number) }
	it { should respond_to(:street) }
	it { should respond_to(:apt_fl) }
	it { should respond_to(:city) }
	it { should respond_to(:state) }
	it { should respond_to(:zip) }

	describe "with valid attributes" do
		let(:address) { factory_address(nil, nil) }
		it { should be_valid }
	end

	describe "with invalid attributes" do
		describe "with invalid house number" do
			let(:address) { factory_address(:number, nil) }
			it { should_not be_valid }
		end

		describe "with invalid street address" do
			describe "with blank street address" do
				let(:address) { factory_address(:street, ' ') }
				it { should_not be_valid }
			end

			describe "with missing street name" do
				let(:address) { factory_address(:street, Faker::Address.street_suffix) }
				it { should_not be_valid }
			end

			describe "with missing street suffix" do
				let(:address) { factory_address(:street, Faker::Address.street_name) }
				it { should_not be_valid }
			end

			describe "with too short of a street suffix" do
				let(:address) { factory_address(:street, Faker::Address.street_suffix.to_s[0,2]) }
				it { should_not be_valid }
			end
		end

		describe "with invalid city" do
			let(:address) { factory_address(:city, ' ') }
			it { should_not be_valid }
		end

		describe "with invalid state" do
			describe "with blank state" do
				let(:address) { factory_address(:state, ' ') }
				it { should_not be_valid }
			end

			describe "with too short state" do
				let (:address) { factory_address(:state, Faker::Address.us_state_abbr[0]) }
				it { should_not be_valid }
			end

			describe "with too long state" do
				let (:address) { factory_address(:state, Faker::Address.us_state) }
				it { should_not be_valid }
			end
		end

		describe "with invalid zip" do
			describe "with too short zip" do
				let (:address) { factory_address(:zip, Faker::Address.zip_code[0, 4]) }
				it { should_not be_valid }
			end

			describe "with too long zip" do
				let (:address) { factory_address(:zip, "#{Faker::Address.zip_code}0") }
				it { should_not be_valid }
			end

			describe "with non-numerical zip" do
				let (:address) { factory_address(:zip, "#{Faker::Address.zip_code}X") }
				it { should_not be_valid }
			end

			describe "with blank zip" do
				let (:address) { factory_address(:zip, ' ') }
				it { should_not be_valid }
			end
		end

		describe "with non-numerical apt/fl number" do
			let (:address) { factory_address(:apt_fl, "a") }
			it { should_not be_valid }
		end

	end
end
