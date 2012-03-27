# == Schema Information
#
# Table name: users
#
#  id               :integer         not null, primary key
#  first            :string(255)     not null
#  middle           :string(255)
#  last             :string(255)     not null
#  birth_date       :date            not null
#  registered_at    :string(255)     not null
#  gender           :string(255)
#  ethnicity        :string(255)
#  household_number :integer         not null
#  household_income :float           not null
#  education_level  :string(255)     not null
#  clearance_level  :string(255)     not null
#  created_at       :datetime        not null
#  updated_at       :datetime        not null
#  user_name        :string(255)     indexed
#

require 'spec_helper'

describe "Users" do

		describe "have valid attributes" do
			@user = factory_user(nil, nil)

			subject { @user }

			it { should be_valid }

			describe "have necessary attributes" do
				it { should respond_to(:first) }
				it { should respond_to(:middle) }
				it { should respond_to(:last) }
				it { should respond_to(:birth_date) }
				it { should respond_to(:registered_at) }
				it { should respond_to(:gender) }
				it { should respond_to(:ethnicity) }
				it { should respond_to(:household_number) }
				it { should respond_to(:household_income) }
				it { should respond_to(:id) }
				it { should respond_to(:education_level) }
				it { should respond_to(:clearance_level) }
				it { should respond_to(:user_name) }
			end
		end

		describe "have invalid attributes" do

			describe "when first name is empty" do
				@user = factory_user(:first, ' ')
				subject { @user }
				it { should_not be_valid }
			end	

			describe "when last name is empty" do
				@user = factory_user(:last, ' ')
				subject { @user }
				it { should_not be_valid }
			end	

			describe "when birth date is empty" do
				@user = factory_user(:birth_date, nil)
				subject { @user }
				it { should_not be_valid }
			end

			describe "when registered at is empty" do
				@user = factory_user(:registered_at, ' ')
				subject { @user }
				it { should_not be_valid }
			end

			describe "when household number is empty" do
				@user = factory_user(:household_number, nil)
				subject { @user }
				it { should_not be_valid }
			end

			describe "when household number is less than 1" do
				@user = factory_user(:household_number, 0)
				subject { @user }
				it { should_not be_valid }
			end

			describe "when household income is empty" do
				@user = factory_user(:household_income, nil)
				subject { @user }
				it { should_not be_valid }
			end

			describe "when household income is less than 0" do
				@user = factory_user(:household_income, -1.0)
				subject { @user }
				it { should_not be_valid }
			end

			describe "when education level is empty" do
				@user = factory_user(:education_level, ' ')
				subject { @user }
				it { should_not be_valid }
			end

			describe "when clearance level is empty" do
				@user = factory_user(:clearance_level, ' ')
				subject { @user }
				it { should_not be_valid }
			end

			describe "when user name is empty" do
				@user = factory_user(:user_name, ' ')
				subject { @user }
				it { should_not be_valid }
			end
		end
end
