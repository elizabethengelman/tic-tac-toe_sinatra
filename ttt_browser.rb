require 'sinatra'
require 'shotgun'
require_relative 'lib/game'
require_relative 'lib/board'
require_relative 'lib/user_interface'
require_relative 'lib/game_loop'
require_relative 'lib/computer'
require_relative 'lib/human_user'


get '/' do
	erb :index
end

get '/start_game' do
	erb :start_game
end

post '/play_game' do
	@user_interface = UserInterface.new
	@game = Game.new(@user_interface)
	@game_loop = GameLoop.new(@user_interface, @game)
	erb :play_game 
end
