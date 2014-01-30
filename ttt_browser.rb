require 'sinatra'
require 'shotgun'
require_relative 'lib/game'
require_relative 'lib/board'
require_relative 'lib/browser_user_interface'
require_relative 'lib/game_loop'
require_relative 'lib/browser_game_loop'
require_relative 'lib/computer'
require_relative 'lib/human_user'


get '/' do
	erb :index
end

get '/start_game' do
	erb :start_game
end

post '/play_game' do
	@first_or_second = params[:first_or_second]
	@browser_user_interface = BrowserUserInterface.new
	@game = Game.new(@browser_user_interface)
	@browser_game_loop = BrowserGameLoop.new(@browser_user_interface, @game)
	@browser_game_loop.play_game(@first_or_second)
	erb :play_game 
end

post '/human_turn/:turn_number' do
end
