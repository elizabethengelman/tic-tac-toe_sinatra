helpers do 
	def current_game
		@game = Game.new(@browser_user_interface)
		session[:game] = @game
	end
end