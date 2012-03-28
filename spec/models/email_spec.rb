# == Schema Information
#
# Table name: emails
#
#  id         :integer         not null, primary key
#  address    :string(255)     not null
#  domain     :string(255)     not null
#  root       :string(255)     not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe "Emails" do

    let(:email) { factory_email(nil, nil) }
    subject { email }

    it { should respond_to(:address) }
    it { should respond_to(:domain) }
    it { should respond_to(:root) }

		describe "relationships" do
			it { should respond_to(:user) }
		end

    describe "with invalid attributes: " do
        context "blank" do
            context "address" do
                let(:email) { factory_email(:address, ' ') }
                it { should_not be_valid }
            end

            context "domain" do
                let(:email) { factory_email(:domain, ' ') }
                it { should_not be_valid }
            end

            context "root" do
                let(:email) { factory_email(:root, ' ') }
                it { should_not be_valid }
            end
        end

        context "too long" do
            context "root" do
                let(:email) { factory_email(:root, 'abcd') }
                it { should_not be_valid }
            end
        end
    end
end
