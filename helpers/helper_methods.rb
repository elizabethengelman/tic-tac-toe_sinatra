helpers do 
	def set_up_game_pieces
		@player_mark = session[:player_mark]
		@human_user = @browser_game_loop.human_user
		@user_interface = BrowserUserInterface.new
		@computer = Computer.new(session[:board], @user_interface, @human_user)	
		@human_user.mark = @player_mark
	end

	def human_move
		session[:board].update_board(@position, @player_mark)
		session[:turn_counter] +=1
	end	

	def computer_move #should something like this be part of the browser loop instead?
		puts "this is the board used for the computer move #{session[:board].board}"
		@computer = Computer.new(session[:board], @user_interface, @human_user)	
		#do I need to reset the computer? should the computer that was created
		#in the helper method save the session[:board]'s updated state?
		computer_turn = @computer.player_turn
		session[:board].update_board(computer_turn[0], computer_turn[1])  ## REFACTOR - THIS IS REPETATIVE
		session[:turn_counter] +=1
	end
end