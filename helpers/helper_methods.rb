helpers do 
	def set_up_game_pieces
		@player_mark = session[:player_mark]
		@human_user = @browser_game_loop.human_user
		@user_interface = BrowserUserInterface.new
		@computer = Computer.new(session[:board], @user_interface, @human_user)	
		@human_user.mark = @player_mark
	end

	def human_move
		puts "this is a valid move? #{session[:board].valid_move?(@position)}"
		session[:board].update_board(@position, @player_mark)
		session[:turn_counter] +=1
	end	

	def computer_move #should something like this be part of the browser loop instead?
		
		@computer = Computer.new(session[:board], @user_interface, @human_user)	
		#do I need to reset the computer? should the computer that was created
		#in the helper method save the session[:board]'s updated state?
		computer_turn = @computer.player_turn
		session[:board].update_board(computer_turn[0], computer_turn[1])  ## REFACTOR - THIS IS REPETATIVE
		session[:turn_counter] +=1
	end

	def game_over?
		if @game.check_for_winner(session[:player_mark], @computer) == "The computer wins!" || @game.check_for_winner(session[:player_mark], @computer) == "Oops, it looks like you win!  That wasn't supposed to happen :|" 
			session[:turn_counter] = 10
		end
	end
end