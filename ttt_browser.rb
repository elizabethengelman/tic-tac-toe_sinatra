require 'sinatra'
require 'shotgun'
require_relative 'lib/game'
require_relative 'lib/board'
require_relative 'lib/browser_user_interface'
require_relative 'lib/game_loop'
require_relative 'lib/browser_game_loop'
require_relative 'lib/computer'
require_relative 'lib/human_user'

enable :sessions

before do 
	@browser_user_interface = BrowserUserInterface.new
	@game = Game.new(@browser_user_interface)
	@browser_game_loop = BrowserGameLoop.new(@browser_user_interface, @game)
end

get '/' do
	erb :index
end

get '/start_game' do
	@browser_game_loop.start_new_game
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
	erb :computer_move
end



get '/end_game' do
	session.clear
	redirect '/'
end
