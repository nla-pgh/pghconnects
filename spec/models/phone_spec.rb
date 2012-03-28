# == Schema Information
#
# Table name: phones
#
#  id         :integer         not null, primary key
#  area       :string(255)     not null
#  carrier    :string(255)     not null
#  line       :string(255)     not null
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe "Phones" do

    let (:phone) { factory_phone(nil, nil) }
    subject { phone }

    it { should respond_to(:area) }
    it { should respond_to(:carrier) }
    it { should respond_to(:line) }

    it { should be_valid }

    describe "has invalid attributes:" do
        context "non-numerical" do
            context "area code" do
                let(:phone) { factory_phone(:area, 'XXX') }
                it { should_not be_valid }
            end

            context "carrier code" do
                let(:phone) { factory_phone(:carrier, 'XXX') }
                it { should_not be_valid }
            end

            context "line code" do
                let(:phone) { factory_phone(:line, 'XXXX') }
                it { should_not be_valid }
            end
        end

        context "blank" do
            context "area code" do
                let(:phone) { factory_phone(:area, ' ') }
                it { should_not be_valid }
            end

            context "carrier code" do
                let(:phone) { factory_phone(:carrier, ' ') }
                it { should_not be_valid }
            end

            context "line code" do
                let(:phone) { factory_phone(:line, ' ') }
                it { should_not be_valid }
            end
        end

        context "too long" do
            context "area code" do
                let(:phone) { factory_phone(:area, '4567') }
                it { should_not be_valid }
            end

            context "carrier code" do
                let(:phone) { factory_phone(:carrier, '1234') }
                it { should_not be_valid }
            end

            context "line code" do
                let(:phone) { factory_phone(:line, '12345') }
                it { should_not be_valid }
            end
        end

        context "too short" do
            context "area code" do
                let(:phone) { factory_phone(:area, '12') }
                it { should_not be_valid }
            end

            context "carrier code" do
                let(:phone) { factory_phone(:carrier, '12') }
                it { should_not be_valid }
            end

            context "line code" do
                let(:phone) { factory_phone(:line, '123') }
                it { should_not be_valid }
            end
        end
    end
end
