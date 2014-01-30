class Game
  SPACE = " "
  attr_reader :board, :turn_counter
  
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
    print_board #this should not be a part of take_a_turn??
  end
  
  def in_progress?
    @turn_counter < 9
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

  def check_for_winner(human_user, computer) 
    @board.possible_wins.each do |line|
      if @board.times_in_line(line, human_user.mark) == 3
        human_user_wins
      elsif @board.times_in_line(line, "O") == 3
        computer_wins
      elsif @turn_counter == 9
        tie_game
      end
    end
  end

  def tie_game
    @user_interface.print_out("You've tied!")
    game_over
  end

  def computer_wins
    @user_interface.print_out("The computer wins!")
    game_over
  end

  def human_user_wins
    @user_interface.print_out("Oops, it looks like you win!  That wasn't supposed to happen :|")
    game_over
  end

  def game_over
    @turn_counter = 10
  end 
end
