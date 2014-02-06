require 'sinatra'
require 'shotgun'
require_relative 'lib/game'
require_relative 'lib/board'
require_relative 'lib/browser_user_interface'
require_relative 'lib/game_loop'
require_relative 'lib/browser_game_loop'
require_relative 'lib/computer'
require_relative 'lib/human_user'
require_relative 'helpers/helper_methods'

enable :sessions

before do 
	@browser_user_interface = BrowserUserInterface.new
	@game = Game.new(@browser_user_interface)
	@browser_game_loop = BrowserGameLoop.new(@browser_user_interface, @game)
	@browser_game_loop.start_new_game
end

get '/' do
	erb :index
end

get '/start_game' do
	session[:board] = @browser_game_loop.board
	session[:turn_counter] = @game.turn_counter
	erb :start_game
end

post '/first_move' do
	@first_or_second = params[:first_or_second]
	@player_mark = params[:mark]
	session[:player_mark] = @player_mark
	if @first_or_second == "first"
		@available_moves = list_available_moves
		erb :human_move
	elsif @first_or_second == "second" ## REFACTOR - THIS IS REPETATIVE
		set_up_game_pieces
		# @computer = Computer.new(session[:board], @user_interface, @human_user)	
		# computer_turn = @computer.player_turn
		# session[:board].update_board(computer_turn[0], computer_turn[1])
		# session[:turn_counter] +=1
		computer_move
		erb :computer_move
	end
end

post '/human_move' do
	@position = params[:move].to_i
	set_up_game_pieces
	human_move
	computer_move
	@game.reset([@human_user, @computer], session[:board])
	@game.turn_counter = session[:turn_counter]
	game_over?
	
	erb :computer_move
end

get '/human_move' do
	@available_moves = list_available_moves
	erb :human_move
end


get '/end_game' do
	session.clear
	redirect '/'
end
