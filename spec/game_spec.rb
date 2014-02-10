require 'spec_helper'

class GameMockUserInterface
	attr_reader :print_out_array
	attr_accessor :input_counter
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
			"test"
		elsif @input_counter == 2
			"first"
		elsif @input_counter == 3
			"second"
		end
	end
end

class MockPlay
	attr_accessor :board
	def initialize(user,game)
		@mock_user = user
		@game = game
		@board = Board.new
	end
end

class MockPlayer
	def initialize(board, user_interface)
		@board = board
		@user_interface = user_interface
	end
end

class Game #need to get rid of this! it's changing the behavior of the class?
	attr_accessor :turn_counter
end

describe Game do
	before :each do
		@mock_user_interface = GameMockUserInterface.new
		@game = Game.new(@mock_user_interface)
		@mock_play = MockPlay.new(@mock_user_interface, @game)
		@board = @mock_play.board
    @human_user = HumanUser.new(@board, @user_interface)
    @computer = Computer.new(@board, @user_interface, @human_user)
	end

	describe "#print_welcome" do
		it "prints out a welcome message" do
			@game.reset([@human_user, @computer], @board)
			@game.print_welcome
			@mock_user_interface.print_out_array[0].should eq "Welcome to tic-tac-toe!"
		end
	end

	describe "#print_board" do
		it "prints out the current board" do
			@game.reset([@human_user, @computer], @board)
			@game.board.update_board(1,"X")
			@game.print_board
			@mock_user_interface.print_out_array[0].should eq [
      "X |   |  ",
      "_________",
      "  |   |  ",
      "_________",
      "  |   |  "
  	  ]
		end
	end

	describe "#print_example_board" do
		it "prints out and example board" do
		@game.reset([@human_user, @computer], @board)
		@game.print_example_board
		@mock_user_interface.print_out_array[1].should eq [
  		"1 | 2 | 3",
  		"_________",
  		"4 | 5 | 6",
  		"_________",
  		"7 | 8 | 9",
  		"",
  		""
  		]
  	end
	end

	describe "#take_a_turn" do
		before :each do
			@player = MockPlayer.new(@board, @mock_user_interface)
			@game.reset([@player1, @player2], @board)
		end		

		it "calls player turn, and updates the board with the moves the player puts in" do			
			@player.should_receive(:player_turn).and_return([1, "X"])
			@game.take_a_turn(@player)
			@game.board.board.should == {1 => "X", 2 => " ", 3 => " ", 4 => " ", 5 => " ", 6 => " ", 7 => " ", 8 => " ", 9 => " "}
		end
	end

	describe "#over?" do
		it "returns false the board is empty" do
			@game.reset([@human_user, @computer], @board)
			@game.over?.should eq false
		end

		it "returns false if the game is still in progress" do
			@game.reset([@human_user, @computer], @board)
			@game.board.update_board(1, "X")
			@game.over?.should eq false
		end

		it "returns true if the game is over" do
			@game.reset([@human_user, @computer], @board)
			@game.board.board.each do |key, value|
    		@game.board.update_board(key,key)
    	end
			@game.over?.should eq true
		end
	end

	describe "#who_goes_first?" do
		it "should print out to ask if the human user would like to go first or second" do
			@game.who_goes_first?
			@mock_user_interface.print_out_array[0].should eq "Would you like to go first or second? Please enter 'first' or 'second'."
		end

		it "should get input from the human user" do
			@game.who_goes_first?
			@mock_user_interface.input_counter.should == 2
		end

		it "should continue asking the user, until they put 'first' or 'second'" do
			@game.who_goes_first?
			@mock_user_interface.print_out_array[1].should eq "Would you like to go first or second? Please enter 'first' or 'second'."
		end

		it "should return the index of the human_user, 0, if the user wants to go first" do
			@game.who_goes_first?.should == 0
		end

		it "should return the index of the computer, 1, if the user wants to go second" do
			@mock_user_interface.input_counter = 2
			@game.who_goes_first?.should == 1
		end
	end

	describe "#change_turn" do
		before :each do 
			@game.reset([@human_user, @computer], @board)
			@game.change_turn
		end

		it "should add 1 to the turn counter" do
			@game.turn_counter.should eq 1 
		end
	end

	describe "#check_for_winner" do
    before :each do
      @game.reset([@human_user.mark, @computer], @board)
    end

    it "should print out that the human use won if there are 3 X's in a row" do
      @game.board.update_board(1,"X")
      @game.board.update_board(2,"X")
      @game.board.update_board(3,"X")
      @game.check_for_winner(@human_user.mark, @computer)
    	@mock_user_interface.print_out_array[0].should eq "Oops, it looks like you win!  That wasn't supposed to happen :|"
    end

    it "should print out that the computer has won if there are 3 O's in a row" do
      @game.board.update_board(1,"O")
      @game.board.update_board(2,"O")
      @game.board.update_board(3,"O")
    	@game.check_for_winner(@human_user.mark, @computer)
    	@mock_user_interface.print_out_array[0].should eq "The computer wins!"
    end

    it "should print out that it is a tied game" do
    	@game.board.board.each do |key, value|
    		@game.board.update_board(key,key)
    	end
      @game.check_for_winner(@human_user.mark, @computer)
      @mock_user_interface.print_out_array[0].should eq "You've tied!"
    end
  end

	describe "#game_over" do
		it "should end the game by setting the turn counter to 6" do
			@game.game_over
			@game.turn_counter.should eq 11
		end	
	end

	context "to delete" do
		before :each do
		   @game.reset([@human_user.mark, @computer], @board)
		end

		it "returns x when x marks the first row" do	
			(1..3).each do |number|
				@game.board.update_board(number, "X")
			end
			@game.winner.should eq "X"
		end

		it "returns nil when there is no winner" do
			@game.winner.should eq nil
		end

		it "returns O when O marks the second row" do
			(4..6).each do |number|
				@game.board.update_board(number, "O")
			end
			@game.winner.should eq "O"
		end


		it "returns winner when player marks diagonal" do
			[1, 5, 9].each do |number|
				@game.board.update_board(number, "C")
			end
			@game.winner.should eq "C"
		end
	end
end











