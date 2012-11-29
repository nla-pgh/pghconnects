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
#  user_id         :integer
#  education_level :string(255)
#

require 'spec_helper'

describe "Educations" do

    subject { edu }
    
    before do
        @base_attrs = {
            :institution => "Carnegie Mellon University",
            :focus => "Computer Science",
            :credential => "Bachelor of Science",
            :school_id => '',
            :finish_on => Date.today
        }
    end

    describe "sanity check" do
        let(:edu) { factory(:education, @base_attrs, nil) }

        it { should respond_to(:education_level) }
        it { should respond_to(:institution) }
        it { should respond_to(:focus) }
        it { should respond_to(:credential) }
        it { should respond_to(:school_id) }
        it { should respond_to(:finish_on) }

        describe "relationships" do
            it { should respond_to(:user) }

            context "with correct structure" do
                let(:edu) { factory(:education, @base_attrs, :user_id => 0) }
                it { should respond_to(:user_id) }
                it { should be_valid }
            end
        end
    end
end
