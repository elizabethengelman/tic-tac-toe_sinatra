require 'spec_helper'

describe UserInterface do
	before :all do
		@user_interface = UserInterface.new
	end

	describe "#get_input" do
    let(:user_input) { "first" }
    it "should be 'first'" do
    	@user_interface.get_input(user_input).should == "first"
    end
	end

	describe "#print_out" do
		it "should print out the output" do
			@user_interface.should_receive(:puts).with("test output")
			@user_interface.print_out("test output")
		end
	end
end
