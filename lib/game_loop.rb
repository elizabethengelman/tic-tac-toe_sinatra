class GameLoop
	
	def initialize(user_interface, game)
		@user_interface = user_interface
		@game = game
		@current_player = 0
	end
  
	def start_playing
	  response = "yes"
	  until response != "yes"
		  play_game
		  @user_interface.print_out("Game over! Would you like to start a new game? Enter 'yes'") #should this be a funtion of the Game class?
		  response = @user_interface.get_input
	  end
	  @user_interface.print_out("Thanks for playing! Goodbye!")
	end

	def play_game
    create_new_game_pieces
    @game.reset(@players, @board)
    @game.print_welcome
    current_player_index = @game.who_goes_first?
    assign_player_marks
    @game.print_example_board
    while @game.in_progress?
			current_player = @players[current_player_index]
	    @game.take_a_turn(current_player)
      current_player_index = (current_player_index + 1) % 2
      @game.change_turn
      @game.check_for_winner(@human_user, @computer)
    end
  end

  def create_new_game_pieces
  	@board = Board.new
    @human_user = HumanUser.new(@board, @user_interface)
    @computer = Computer.new(@board, @user_interface, @human_user)
    @players = [@human_user, @computer]
  end

  def assign_player_marks
  	@human_user.choose_your_mark
    @computer.assign_computer_mark
  end
end
