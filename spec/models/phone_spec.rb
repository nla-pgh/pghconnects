# == Schema Information
#
# Table name: phones
#
#  id         :integer         not null, primary key
#  area       :string(255)
#  carrier    :string(255)
#  line       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  user_id    :integer
#  full       :string(255)     not null
#

require 'spec_helper'

describe "Phones" do

    subject { phone }

    before do
        @base_attrs = { :full => "123-456-7890" }
    end

    describe "sanity check" do
        let (:phone) { factory( :phone, @base_attrs, nil ) }

				before { phone.save! }
        it { should respond_to(:area) }
        it { should respond_to(:carrier) }
        it { should respond_to(:line) }
        it { should respond_to(:full) }

				it { phone.area == "123" }
				it { phone.carrier == "456" }
				it { phone.line == "7890" }

        describe "relationships" do
            it { should respond_to(:user) }

            context "with correct structure" do
                let(:phone) { factory( :phone, @base_attrs, :user_id => 0) }
                it { should respond_to(:user_id) }
                it { should be_valid }
            end
        end
    end

    describe "has invalid attributes:" do
        context "too short" do
            context "full" do
                let (:phone) { factory(:phone, @base_attrs, :full => "123" ) }
                it { should_not be_valid }
            end
        end

        context "too long" do
            context "full" do
                let (:phone) { factory(:phone, @base_attrs, :full => "1"*12 ) }
                it { should_not be_valid }
            end
        end

        context "invalid format" do
            %w(1---12321 1001010101010 100-121-121 1-111-111-111 1-11-111-11).each do |number|
                let (:phone) { factory(:phone, @base_attrs, :full => number) }
                it { should_not be_valid }
            end
        end
    end

    describe "has valid attributes:" do
        %w(1-800-121-1232 4123435678 412-322-1234).each do |number|
            let (:phone) { factory( :phone, @base_attrs, :full => number ) }
            it { should be_valid }
        end
    end
end
