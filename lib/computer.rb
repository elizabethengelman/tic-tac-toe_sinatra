class Computer
  SPACE = " "
  
	def initialize(board, user_interface, human_user)
		@board = board
    @user_interface = user_interface
    @human_user = human_user
    @computer_mark = "O"
  end

  def assign_computer_mark
    if @human_user.mark == "O"
      @computer_mark = "X"
    end
  end

  def player_turn
    @user_interface.print_out("The computer is playing...")
    if @board.board[5] == SPACE
      position = 5
    else
      position = find_computer_move
    end
    [position, @computer_mark]
  end

  def three_in_a_row_possible?(line)
    @board.times_in_line(line, @computer_mark) == 2 && @board.empty_in_line(line)
  end

  def block_opponent_possible?(line)
    @board.times_in_line(line, @human_user.mark) == 2 && @board.empty_in_line(line)
  end

  def start_building_a_win?(line)
    @board.times_in_line(line, @computer_mark) == 1 && @board.empty_in_line(line)
  end

  def find_computer_move
    @board.possible_wins.each do |line|
      if three_in_a_row_possible?(line)
        return @board.empty_in_line(line)
      end
    end
    @board.possible_wins.each do |line|
      if block_opponent_possible?(line)
        return @board.empty_in_line(line)
      end 
    end
    @board.possible_wins.each do |line|
      if start_building_a_win?(line)
        return @board.empty_in_line(line)
      end
    end
    3
  end
end