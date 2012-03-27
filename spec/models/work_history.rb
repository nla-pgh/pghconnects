require 'spec_helper'

describe "WorkHistory" do

	let (:wh) { WorkHistory.new }
	subject { wh }

	it { should respond_to(:business) }
	it { should respond_to(:start) }
	it { should respond_to(:end) }
	it { should respond_to(:description) }
	it { should respond_to(:title) }
end
