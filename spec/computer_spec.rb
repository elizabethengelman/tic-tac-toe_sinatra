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
end

class MockHumanUser
	attr_accessor :mark
	def initialize(board, mock_user_interface)
		@mark = "X"
	end
end


describe Computer do
	before :each do
		@board = Board.new
		@mock_user_interface = MockUserInterface.new
		@mock_human_user = MockHumanUser.new(@board, @mock_user_interface)
		@computer = Computer.new(@board, @mock_user_interface, @mock_human_user)
	end

	describe "#player_turn" do

		before :each do
			@computer.player_turn
		end

		it "should print out a message that the computer is playing" do
			@mock_user_interface.print_out_array[0].should eq "The computer is playing..."
		end

		it "should return 5 if that space is available" do
			@computer.player_turn.should eq [5,"O"]
		end

		it "should run the find_computer_move method if 5 is not available" do
			@board.update_board(5,"X")
			@computer.should receive(:find_computer_move)
			@computer.player_turn
		end	
	end

	describe "#find_computer_move" do

		it "should return the winning move if the computer has 2 marks in a line" do
			@board.update_board(1,"O")
			@board.update_board(2,"O")
			@computer.find_computer_move.should eq 3
		end

		it "should return a blocking move, if the user has 2 marks in a line" do
			@board.update_board(1,"X")
			@board.update_board(4,"X")
			@computer.find_computer_move.should eq 7
		end

		it "should begin building a win, if the computer has 1 mark in a line" do
			@board.update_board(1,"O")
			@computer.find_computer_move.should eq 2
		end

		it "if no other moves avaible, it should return 3" do
			@board.update_board(1, "X")
			@computer.find_computer_move.should eq 3
		end	
	end

	describe "#assign_computer_mark" do
		it "should return X if the human has already chosen to use 'O'" do 
			@mock_human_user.mark = "O"
			@computer.assign_computer_mark.should == "X"
		end	
	end
end	