require 'spec_helper'

describe Board do
	before :each do
		@board = Board.new
	end

	describe "#print_board" do
		it "should return the current board" do
			@board.print_board.should eq [
      "#{@board.board[1]} | #{@board.board[2]} | #{@board.board[3]}",
      "_________",
      "#{@board.board[4]} | #{@board.board[5]} | #{@board.board[6]}",
      "_________",
      "#{@board.board[7]} | #{@board.board[8]} | #{@board.board[9]}"
  	]
	  end
	end

	describe "print_example_board" do
		it "should return an example board" do
			@board.print_example_board.should eq [
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

	describe "#update_board" do
    it "should update the board at the position given, with the mark given" do
      @board.update_board(1,"X")
      @board.board[1].should eq "X"
    end 
  end

  describe "#times_in_line" do
    it "should find how many times a certain mark(O or X) is in a specific line" do
      @board.update_board(1,"X")
      @board.update_board(2, "X")
      @board.times_in_line([1,2,3], "X").should eq 2
    end

    it "should return 0, if the mark does not appear in the specific line" do
      @board.times_in_line([1,2,3], "X").should eq 0
    end
  end


  describe "#empty_in_line" do
    before :each do 
      @possible_winning_line = @board.possible_wins[0]
    end

    it "should return the index of the first empty space in the line" do
      @board.empty_in_line(@possible_winning_line).should eq 1
    end

    it "should return the next available space if the first space is full" do
      @board.update_board(1, "X")
      @board.empty_in_line(@possible_winning_line).should eq 2
    end

    it "should not return an index if there is not empty space in the line" do
      @board.update_board(1,"X")
      @board.update_board(2,"X")
      @board.update_board(3,"O")
      @board.empty_in_line(@possible_winning_line).should == [1,2,3]
    end
  end

  describe "#valid_move?" do 
    it "should return true if the space is open" do
      @board.valid_move?(1).should equal true
    end

    it "should return false if the space is not open" do
      @board.update_board(1,"X")
      @board.valid_move?(1).should equal false
    end

    it "should return false if the move is not part of the board" do
      @board.valid_move?(10).should equal false
    end
  end
end
