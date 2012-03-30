# == Schema Information
#
# Table name: educations
#
#  id              :integer         not null, primary key
#  institution     :text
#  focus           :text
#  credential      :string(255)
#  school_id       :string(255)
#  finish_on       :date
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  user_id         :integer         not null
#  education_level :string(255)
#

require 'spec_helper'

describe "Educations" do

    let(:edu) { factory_edu(nil, nil) }
    subject { edu }

    it { should respond_to(:education_level) }
    it { should respond_to(:institution) }
    it { should respond_to(:focus) }
    it { should respond_to(:credential) }
    it { should respond_to(:school_id) }
    it { should respond_to(:finish_on) }

    describe "relationships" do
        it { should respond_to(:user) }

        context "with correct structure" do
            let(:edu) { factory_edu(:user_id, 0) }
            it { should respond_to(:user_id) }
            it { should be_valid }

            context "with invalid attributes:" do
                context "blank user id" do
                    let(:edu) { factory_edu(:user_id, nil) }
                    it { should_not be_valid }
                end

                context "negative user id" do
                    let(:edu) { factory_edu(:user_id, -1) }
                    it { should_not be_valid }
                end
            end
        end
    end

    describe "with invalid attributes:" do
        context "education level is empty" do
            let(:user) { factory_user(:education_level, ' ') }
            it { should_not be_valid }
        end
    end
end
