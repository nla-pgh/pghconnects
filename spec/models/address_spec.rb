# == Schema Information
#
# Table name: addresses
#
#  id               :integer         not null, primary key
#  number           :integer         not null
#  street           :string(255)     not null
#  apt_fl           :string(255)
#  city             :string(255)     not null
#  state            :string(255)     not null
#  zip              :string(255)     not null
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#  user_id          :integer
#  household_number :integer         not null
#  household_income :float           not null
#

require 'spec_helper'

describe "Addresses" do
	subject { address }

    before do
        @base_attrs = {
            :number => 5429,
            :street => "#{Faker::Address.street_name} #{Faker::Address.street_suffix}",
            :apt_fl => 1,
            :city => Faker::Address.city,
            :state => Faker::Address.us_state_abbr,
            :zip => Faker::Address.zip_code[0,5],
            :household_number => 1,
            :household_income => 1.0
        }
    end

    describe "sanity check" do
        let (:address) { factory( :address, @base_attrs, nil) }

        it { should respond_to(:number) }
        it { should respond_to(:street) }
        it { should respond_to(:apt_fl) }
        it { should respond_to(:city) }
        it { should respond_to(:state) }
        it { should respond_to(:zip) }
        it { should respond_to(:household_number) }
        it { should respond_to(:household_income) }

        describe "relationships" do 
            it { should respond_to(:user) }
            
            context "with correct structure" do
                it { should respond_to(:user_id) }

                let(:address) { factory( :address, @base_attrs, :user_id => 0) }
                it { should be_valid }
            end
        end
    end

	describe "with invalid attributes:" do
        context "blank" do
            # Addresses
            context "house number" do
                let(:address) { factory(:address, @base_attrs, :number => nil ) }
                it { should_not be_valid }
            end

            context "street address" do
				let(:address) { factory(:address, @base_attrs, :street => ' ') }
				it { should_not be_valid }
            end

            context "street name" do
				let(:address) { factory(:address, @base_attrs, :street => Faker::Address.street_suffix) }
				it { should_not be_valid }
            end

            context "street suffix" do
				let(:address) { factory(:address, @base_attrs, :street => Faker::Address.street_name.sub(' ', '') ) }
				it { should_not be_valid }
            end

            # City
            context "city name" do
                let(:address) { factory(:address, @base_attrs, :city => ' ') }
                it { should_not be_valid }
            end

            # State
            context "state abbr" do
				let(:address) { factory(:address, @base_attrs, :state => ' ') }
				it { should_not be_valid }
            end

            # Zip
            context "zip" do
				let (:address) { factory(:address, @base_attrs, :zip => ' ') }
				it { should_not be_valid }
            end

            # Household number
            context "household number" do
                let(:address) { factory(:address, @base_attrs, :household_number => nil) }
                it { should_not be_valid }
            end

            context "household income" do
                let(:address) { factory(:address, @base_attrs, :household_income => nil) }
                it { should_not be_valid }
            end
		end

        context "length is invalid for" do
            # Address
            context "street suffix - too short" do
				let(:address) { factory(:address, @base_attrs, :street => Faker::Address.street_suffix.to_s[0,2]) }
				it { should_not be_valid }
			end

            # State
			context "state - too short" do
				let (:address) { factory(:address, @base_attrs, :state => Faker::Address.us_state_abbr[0,1]) }
				it { should_not be_valid }
			end

			context "state - too long" do
				let (:address) { factory(:address, @base_attrs, :state => Faker::Address.us_state) }
				it { should_not be_valid }
			end

            # Zip
			context "zip - too short" do
				let (:address) { factory(:address, @base_attrs, :zip => Faker::Address.zip_code[0, 4]) }
				it { should_not be_valid }
			end

			context "zip - too long" do
				let (:address) { factory(:address, @base_attrs, :zip => "#{Faker::Address.zip_code}000000000") }
				it { should_not be_valid }
			end
        end

        context "non-numerical" do
			context "zip" do
				let (:address) { factory(:address, @base_attrs, :zip => "#{Faker::Address.zip_code}XXXXXX") }
				it { should_not be_valid }
			end
		end

        context "invalid number" do
            # Address
            context "negative address number" do
                let (:address) { factory(:address, @base_attrs, :number => -1) }
                it { should_not be_valid }
            end

            # Zip
            context "negative zip" do
                let (:address) { factory(:address, @base_attrs, :zip => -1) }
                it { should_not be_valid }
            end

            context "household number - 0" do
                let(:address) { factory(:address, @base_attrs, :household_number => 0) }
                it { should_not be_valid }
            end

            context "household income - negative" do
                let(:address) { factory(:address, @base_attrs, :household_income => -1.0) }
                it { should_not be_valid }
            end
        end
	end
end
