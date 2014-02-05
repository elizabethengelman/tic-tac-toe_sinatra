helpers do 
	def set_up_game_pieces
		@player_mark = session[:player_mark]
		@human_user = @browser_game_loop.human_user
		@user_interface = BrowserUserInterface.new
		@computer = Computer.new(session[:board], @user_interface, @human_user)	
		@human_user.mark = @player_mark
	end
end