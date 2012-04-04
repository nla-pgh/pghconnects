# == Schema Information
#
# Table name: emails
#
#  id         :integer         not null, primary key
#  address    :string(255)
#  domain     :string(255)
#  root       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  user_id    :integer
#  full       :string(255)     not null
#

require 'spec_helper'

describe "Emails" do

    subject { email }

    before do
        @base_attrs = { :full => "test@test.com" }
    end

    describe "sanity check" do
        let(:email) { factory(:email, @base_attrs, nil) }

				before { email.save! }
				it { email.address.should == "test" }
				it { email.domain.should == "test" }
				it { email.root.should == "com" }

        describe "relationships" do
            it { should respond_to(:user) }

            context "with correct structure" do
                let(:email) { factory(:email, @base_attrs, :user_id => 0) }
                it { should respond_to(:user_id) }
                it { should be_valid }
            end
        end
    end

    describe "with invalid attributes: " do
        context "blank full" do
            let(:email) { factory(:email, @base_attrs, :full => ' ') }
            it { should_not be_valid }
        end

        context "invalid email formats" do
            invalid_addresses =  %w[user@foo,com user_at_foo.org example.user@foo.]
            invalid_addresses.each do |invalid_address|
                let (:email) { factory(:email, @base_attrs, :full => invalid_address) }
                it { should_not be_valid }
            end
        end
    end
end
