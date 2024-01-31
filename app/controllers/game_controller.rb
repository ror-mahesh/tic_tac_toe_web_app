class GameController < ApplicationController
  before_action :initialize_game, only: [:index, :reset]

  def index
    # Display the tic-tac-toe board
    @board = session[:board]
    @current_player = session[:current_player]
    @winner = session[:winner]
  end

  def end_turn
    # Handle user input and update the board state
    row = params[:row].to_i
    col = params[:col].to_i

    if valid_move?(row, col)
      make_move(row, col)
      check_winner
      switch_player
    else
      flash[:error] = 'Invalid move. Please try again.'
    end

    redirect_to root_path
  end

  def reset
    # Reset the game state
    session[:board] = Array.new(3) { Array.new(3, nil) }
    session[:current_player] = 'X'
    session[:winner] = nil

    redirect_to root_path
  end

  private

  def initialize_game
    # Initialize game state
    session[:board] ||= Array.new(3) { Array.new(3, nil) }
    session[:current_player] ||= 'X'
    session[:winner] ||= nil
  end

  def valid_move?(row, col)
    # Check if the move is valid
    @board[row][col].nil?
  end

  def make_move(row, col)
    # Update the board with the current player's symbol
    @board[row][col] = @current_player
  end

  def switch_player
    # Switch to the next player
    session[:current_player] = (@current_player == 'X') ? 'O' : 'X'
  end

  def check_winner
    # Check if there's a winner
    # Implement your logic here
    # Update session[:winner] accordingly
  end
end
