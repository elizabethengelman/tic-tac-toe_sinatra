require 'spec_helper'

class MockUserInterface
	attr_reader :print_out_array
	def initialize
		@print_out_array = []
		@input_counter = 0
	end
	
	def print_out(output)
		@print_out_array << output
	end

	def get_input
		@input_counter += 1
		if @input_counter == 1
			"E"
		else
			2
		end
	end
end

describe HumanUser do
	before :each do
		@board = Board.new
		@mock_user_interface = MockUserInterface.new
		@human_user = HumanUser.new(@board,@mock_user_interface)
	end

describe "#player_turn" do
		it "prints out a message asking the user where to place their mark" do
			@human_user.player_turn
			@mock_user_interface.print_out_array[0].should eq "Where would you like to place your mark?"
		end

		it "should tell the user if they've input an invalid move" do
			@human_user.player_turn
			@mock_user_interface.print_out_array[1].should eq "Sorry, that is not a valid move, please try again."
		end

		it "should return the user's position" do
			@human_user.player_turn.should eq [2,"X"]
		end
	end

	describe "#choose_your_mark" do
		it "prints out a message asking which mark the user would like to play with" do
			@human_user.choose_your_mark
			@mock_user_interface.print_out_array[0].should eq "Which mark would you like to play with? You can input any character."
		end

		it "gets the user's input" do
			@human_user.choose_your_mark.should == "E"
		end
	end
end
