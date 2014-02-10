class Game
  SPACE = " "
  attr_reader :board
  attr_accessor :turn_counter
  
  def initialize(user_interface)
    @user_interface = user_interface
  end

  def reset(players, board)
    @board = board
    @turn_counter = 0
  end

  def print_welcome
    @user_interface.print_out("Welcome to tic-tac-toe!")
  end

  def print_example_board
    @user_interface.print_out("The board is numbered as follows.")
    @user_interface.print_out(@board.print_example_board)
  end
  
  def print_board
    @user_interface.print_out(@board.print_board)
  end

  def take_a_turn(player) 
    move = player.player_turn
    @board.update_board(move[0],move[1])
    print_board 
  end
  
  def over?
    winner || @board.full?
  end
 
  def who_goes_first?
    input = ""
    until input == "first" 
      @user_interface.print_out("Would you like to go first or second? Please enter 'first' or 'second'.")
      input = @user_interface.get_input
      if input == "first"
        return 0
      elsif input == "second"
        return 1
      end
    end
    end

  def change_turn
    @turn_counter +=1
  end

  def check_for_winner(human_user_mark, computer) 
    result = ""
    winner_mark = winner
    if winner == human_user_mark
      result = human_user_wins
    elsif winner == computer.computer_mark
        result = computer_wins
    elsif @board.full?
      result =  tie_game
    end
    result
  end

  def winner
    @board.possible_wins.each do |line|
      first_value = @board.value(line.first)
      if (first_value != SPACE) && same_mark_in_line?(line)
        return first_value
      end
    end
    nil
  end

  def same_mark_in_line?(line)
    value = @board.value(line.first)
    @board.values(line).all? {|v| v == value}
  end
 
  def tie_game    
    @user_interface.print_out("You've tied!")
  end

  def computer_wins
    game_over
    @user_interface.print_out("The computer wins!")
  end

  def human_user_wins
    game_over
    @user_interface.print_out("Oops, it looks like you win!  That wasn't supposed to happen :|")
  end

  def game_over
    @turn_counter = 11
  end 
end
