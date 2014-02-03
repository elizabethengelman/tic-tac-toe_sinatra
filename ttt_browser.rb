require 'sinatra'
require 'shotgun'
require_relative 'lib/game'
require_relative 'lib/board'
require_relative 'lib/browser_user_interface'
require_relative 'lib/game_loop'
require_relative 'lib/browser_game_loop'
require_relative 'lib/computer'
require_relative 'lib/human_user'
# require_relative 'helpers/helper_methods'

enable :sessions

before do 
	@browser_user_interface = BrowserUserInterface.new
	@game = Game.new(@browser_user_interface)
	session[:game] = @game
	@browser_game_loop = BrowserGameLoop.new(@browser_user_interface, @game)
	@browser_game_loop.start_new_game
end

get '/' do
	erb :index
end

get '/start_game' do
	session[:computer] = @browser_game_loop.computer
	session[:human_user] = @browser_game_loop.human_user
	session[:board] = @browser_game_loop.board
	erb :start_game
end

post '/first_move' do
	@first_or_second = params[:first_or_second]
	@player_mark = params[:mark]
	session[:player_mark] = @player_mark
	if @first_or_second == "first"
		erb :human_move
	elsif @first_or_second == "second"
		erb :computer_move
	end
end

post '/human_move' do
	@position = params[:move].to_i
	@player_mark = session[:player_mark]
	session[:board].update_board(@position, @player_mark)
	computer_turn = session[:computer].player_turn
	session[:board].update_board(computer_turn[0], computer_turn[1])
	@game.check_for_winner(session[:human_user], session[:computer])
	erb :computer_move
end

get '/human_move' do
	erb :human_move
end



get '/end_game' do
	session.clear
	redirect '/'
end
