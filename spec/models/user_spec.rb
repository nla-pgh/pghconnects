# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  first           :string(255)     not null
#  middle          :string(255)
#  last            :string(255)     not null
#  birth_date      :date            not null
#  registered_at   :string(255)     not null
#  gender          :string(255)
#  ethnicity       :string(255)
#  clearance_level :string(255)     default("U"), not null
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  user_name       :string(255)
#  site_id         :integer
#

require 'spec_helper'

describe "Users" do

    subject { user }

    before do
        @attrs = {
            :first => Faker::Name.first_name,
            :last => Faker::Name.last_name,
            :birth_date => Date.today,
            :registered_at => "BGC",
            :gender => "Female",
            :ethnicity => "Black",
            :user_name => Faker::Internet.user_name,
            :clearance_level => "U",
        }
    end

    describe "sanity check" do
        let (:user) { factory( :user, @attrs, nil ) }

        it { should respond_to(:first) }
        it { should respond_to(:middle) }
        it { should respond_to(:last) }
        it { should respond_to(:birth_date) }
        it { should respond_to(:registered_at) }
        it { should respond_to(:gender) }
        it { should respond_to(:ethnicity) }
        it { should respond_to(:clearance_level) }
        it { should respond_to(:user_name) }
				it { should respond_to(:password_digest) }
				it { should respond_to(:password) }
				it { should respond_to(:password_confirmation) }
				it { should respond_to(:authenticate) }

        context "with relationships" do
            it { should respond_to(:addresses) }
            it { should respond_to(:phones) }
            it { should respond_to(:emails) }
            it { should respond_to(:educations) }
            it { should respond_to(:work_histories) }

            it { should respond_to(:site) }

            context "with correct structure" do
                let(:user) { factory( :user, @attrs, :site_id => 0) }

								before { user.password = user.password_confirmation = 'password' }

                it { should respond_to(:site_id) }
                it { should be_valid }
            end
        end
    end


    describe "have invalid attributes:" do
        context "blank" do
            context "first name" do
                let(:user) { factory( :user, @attrs, :first => ' ') }
                it { should_not be_valid }
            end

            context "last name" do
                let (:user) { factory( :user, @attrs, :last => ' ') }
                it { should_not be_valid }
            end

            context "birth date" do
                let(:user) { factory( :user, @attrs, :birth_date => nil) }
                it { should_not be_valid }
            end

            context "registered at" do
                let(:user) { factory( :user, @attrs, :registered_at => ' ') }
                it { should_not be_valid }
            end

						context "password" do
							let(:user) { factory( :user, @attrs, nil) }
							before { user.password = user.password_confirmation = ' ' }
							it { should_not be_valid }
						end

						context "password_confirmation" do
							let(:user) { factory( :user, @attrs, nil) }
							before { user.password = user.password_confirmation = nil }
							it { should_not be_valid }
						end
        end	

        context "middle name too long" do
            let(:user) { factory(:user, @attrs, :middle => "a"*4) }
            it { should_not be_valid }
        end

				context "password and password confirmation differs" do
					let(:user) { factory( :user, @attrs, nil) }
					before do
						user.password = "password"
						user.password_confirmation = "invalid"
					end

					it { should_not be_valid }
				end
    end

		describe "return value of authenticate method" do
			let (:user) { factory( :user, @attrs, nil ) }
			
			before do 
				user.password = user.password_confirmation = "password"
				user.save!
			end

			let (:user_found) { User.find_by_user_name(user.user_name) }

			describe "with valid password" do
				it { should == user_found.authenticate(user.password) }
			end

			describe "with invalid password" do
				let (:user_invalid_password) { user_found.authenticate("invalid") }

				it { should_not == user_invalid_password }
				specify { user_invalid_password.should be_false }
			end
	 end
end
