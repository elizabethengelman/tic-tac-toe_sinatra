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

	def computer_move 
		@computer = Computer.new(session[:board], @user_interface, @human_user)	
		computer_turn = @computer.player_turn
		session[:board].update_board(computer_turn[0], computer_turn[1]) 
		session[:turn_counter] +=1
	end

	def list_available_moves
		available_moves_array = []
		session[:board].board.each do |key, value|
			if value == "&nbsp;" || value == " " 
				available_moves_array << key
			end
		end
		available_moves_array
	end
end