class HumanUser
  attr_accessor :mark
	def initialize(board, user_interface) 
		@board = board
		@user_interface = user_interface
    @mark = "X"
	end

  def player_turn
    @user_interface.print_out("Where would you like to place your mark?")
    position = @user_interface.get_input.to_i
    until @board.valid_move?(position)
      @user_interface.print_out("Sorry, that is not a valid move, please try again.")
      position = @user_interface.get_input.to_i
    end
    [position, @mark]
  end

  def choose_your_mark
    @user_interface.print_out("Which mark would you like to play with? You can input any character.")
    @mark = @user_interface.get_input
  end
end