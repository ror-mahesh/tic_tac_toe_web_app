class GamesController < ApplicationController
  before_action :initialize_game, only: [:index]
  after_action :set_current_user, only: [:create, :update]

  def index
    @board = session[:board]
    @winner = session[:winner]
  end

  def create
    Game.create(x_player_name: params[:game][:x_player_name], board: board_hash)
    redirect_to root_path
  end

  def update
    find_game.update(o_player_name: params[:game][:o_player_name], status: 'running')
    redirect_to root_path
  end

  def reset
    find_game.update(status: 'rejected') unless find_game.new_record?
    session[:current_player] = nil
    session[:current_user] = nil
    session[:game] = nil
    redirect_to root_path
  end

  private

  def initialize_game
    session[:game] = find_game
    if find_game.x_player_name.nil? || find_game.x_player_name == session[:current_user]
      session[:current_player] = 'Player X'
      session[:opponent_player] = 'Player O'
      session[:opponent] = find_game.o_player_name
    elsif find_game.o_player_name.nil? || find_game.o_player_name == session[:current_user]
      session[:current_player] = 'Player O'
      session[:opponent_player] = 'Player X'
      session[:opponent] = find_game.x_player_name
    end
  end

  def set_current_user
    session[:current_user] = params[:action] == 'create' ? find_game.x_player_name : find_game.o_player_name
    session[:opponent] = params[:action] == 'create' ? find_game.o_player_name : find_game.x_player_name
    session[:current_player] = params[:action] == 'create' ? 'Player X' : 'Player O'
    session[:opponent_player] = params[:action] == 'create' ? 'Player O' : 'Player X'
  end

  def find_game
    @game ||= Game.find(session[:game]['id'])
  rescue
    game = Game.last
    @game ||= game&.panding? ? game : Game.new(board: board_hash)
  end

  def board_hash
    Array.new(3) { Array.new(3, nil) }
  end
end
