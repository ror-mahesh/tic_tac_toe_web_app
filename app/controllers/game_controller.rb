class GameController < ApplicationController
  before_action :initialize_game, only: [:index, :reset]

  def index
    # Display the tic-tac-toe board
    @board =  Game.last&.board || session[:board]
    @current_player = (Game.last&.current_player  == 'X')? 'O' : 'X'
    @winner = Game.last&.current_player if Game.last&.status == "completed"
    @player = Game.last&.o_player_name&.present? && Game.last&.status == 'runing' 
  end

  def create
    @game = (Game&.last&.x_player_name.present? && Game&.last&.o_player_name.present?)? Game.new(status: 'pending') : Game&.last 
    @game.x_player_name ? @game.o_player_name = params[:player_name] : @game.x_player_name = params[:player_name]
    (Game&.last&.o_player_name.present?)? @game.status = 'runing' : ''
    @game.board = Array.new(3) { Array.new(3, nil) }
    @game.save
    redirect_to root_path
  end

  def end_turn
    # Handle user input and update the board state
    row = params[:row].to_i 
    col = params[:col].to_i
    if valid_move?(row, col)
      make_move(row, col)
      # check_winner
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
    Game.last.update(status: 'rejected'); 
    redirect_to root_path
  end

  private

  def initialize_game
    # Initialize game state
    # @game ||= Game.new(status: 'pending')
    # @game.board ||= Array.new(3) { Array.new(3, nil) }
    # if !@game.x_player_name
    #   @game.x_player_name = session[:player_name]
    # elsif !@game.o_player_name
    #   @game.o_player_name = session[:player_name]
    # end
    # @current_player = (@current_player == 'X')? 'O' : 'X'

    # session[:winner] ||= nil
  end

  def valid_move?(row, col)
    # byebug
    # Check if the move is valid
    Game.last.board[row][col].nil?
  end

  def make_move(row, col)
    # Update the board with the current player's symbol
    # byebug
    boards = Game.last
    boards.current_player = boards.board[row][col] =  session[:current_player]
    check_winner(boards.board.flatten)
    boards.save
    # redirect_to root_path
    # @board[row][col] = @current_player
  end

  def switch_player
    # Switch to the next player
    session[:current_player] = (session[:current_player] == 'X') ? 'O' : 'X'
  end

  def check_winner(board)
    # Check if there's a winner
    # Implement your logic here
    # Update session[:winner] accordingly
    win_array = [[0,1,2], [1,4,7], [2,5,8], [0,3,6], [3,4,5], [6,7,8], [0,4,8], [2,4,6]]
    win = win_array.any? do |arr| 
            board[arr[0]] == board[arr[1]] && board[arr[1]] == board[arr[2]] && board[arr[0]] != nil
          end
    if (win)
      Game.last.update(status: 'completed');
      session[:winner] = Game.last.current_player
      # redirect_to root_path
    end
  end
end
