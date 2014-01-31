class BrowserGameLoop
	attr_reader :board
	def initialize(browser_user_interface, game)
		@browser_user_interface = browser_user_interface
		@game = game
		@current_player = 0
	end
  
	# def start_playing
	#   response = "yes"
	#   until response != "yes"
	# 	  play_game
	# 	  @browser_user_interface.print_out("Game over! Would you like to start a new game? Enter 'yes'") #should this be a funtion of the Game class?
	# 	  response = @browser_user_interface.get_input
	#   end
	#   @browser_user_interface.print_out("Thanks for playing! Goodbye!")
	# end

  def start_new_game
    create_new_game_pieces
    @game.reset(@players, @board)
  end


	def play_game(first_or_second)
    create_new_game_pieces
    @game.reset(@players, @board)
    current_player_index = browser_who_goes_first?(first_or_second)
    current_player = @players[current_player_index]
    @game.take_a_turn(current_player)

  end
    # @game.print_welcome
    
    # assign_player_marks
    # @game.print_example_board
    # while @game.in_progress?
			# 
	    # @game.take_a_turn(current_player)
      # current_player_index = (current_player_index + 1) % 2
      # @game.change_turn
      # @game.check_for_winner(@human_user, @computer)
    # end
  

  def browser_who_goes_first?(first_or_second)
    if first_or_second == "first"
      current_player_index = 0
    elsif first_or_second == "second"
      current_player_index = 1
    end
  end

  def create_new_game_pieces
  	@board = Board.new
    @human_user = HumanUser.new(@board, @browser_user_interface)
    @computer = Computer.new(@board, @browser_user_interface, @human_user)
    @players = [@human_user, @computer]
  end

  def assign_player_marks
  	@human_user.choose_your_mark
    @computer.assign_computer_mark
  end
end
