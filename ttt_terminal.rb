require_relative 'lib/game'
require_relative 'lib/board'
require_relative 'lib/user_interface'
require_relative 'lib/game_loop'
require_relative 'lib/computer'
require_relative 'lib/human_user'


user_interface = UserInterface.new
game = Game.new(user_interface)
new_game_loop = GameLoop.new(user_interface, game)
new_game_loop.start_playing