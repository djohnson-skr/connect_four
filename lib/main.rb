require_relative 'board.rb'
require_relative 'player.rb'
require 'colorize'

class Game
  attr_accessor :board, :player1, :player2, :current_player

  def initialize
    @board = Board.new
    @default_piece = @board.default_piece
    @disc = '●'
    @player1 = Player.new('Player1'.red, @disc.red)
    @player2 = Player.new('Player2'.light_yellow, @disc.light_yellow)
    @current_player = @player1
  end

  def play
    instructions
    loop do
      input = get_user_input
      drop_disc(input)
      break if game_over?
      switch_player
    end
    new_game?
  end

  def instructions
    puts "Welcome to Connect Four!\n\n"
    show_board
  end

  def show_board
    puts " 1 2 3 4 5 6 7"
    puts "|#{@board.board[0][0]} #{@board.board[0][1]} #{@board.board[0][2]} #{@board.board[0][3]} #{@board.board[0][4]} #{@board.board[0][5]} #{@board.board[0][6]}|"
    puts "|#{@board.board[1][0]} #{@board.board[1][1]} #{@board.board[1][2]} #{@board.board[1][3]} #{@board.board[1][4]} #{@board.board[1][5]} #{@board.board[1][6]}|"
    puts "|#{@board.board[2][0]} #{@board.board[2][1]} #{@board.board[2][2]} #{@board.board[2][3]} #{@board.board[2][4]} #{@board.board[2][5]} #{@board.board[2][6]}|"
    puts "|#{@board.board[3][0]} #{@board.board[3][1]} #{@board.board[3][2]} #{@board.board[3][3]} #{@board.board[3][4]} #{@board.board[3][5]} #{@board.board[3][6]}|"
    puts "|#{@board.board[4][0]} #{@board.board[4][1]} #{@board.board[4][2]} #{@board.board[4][3]} #{@board.board[4][4]} #{@board.board[4][5]} #{@board.board[4][6]}|"
    puts "|#{@board.board[5][0]} #{@board.board[5][1]} #{@board.board[5][2]} #{@board.board[5][3]} #{@board.board[5][4]} #{@board.board[5][5]} #{@board.board[5][6]}|"
    7.times { print " \u2594".force_encoding('utf-8') } # bottom "bracket" of board
    puts
  end

  def get_user_input
    print "#{@current_player.name} please enter your selection: "
    input = gets.chomp.to_i - 1
    puts
    until check_user_input?(input) do
      print "Please enter a valid input: "
      input = gets.chomp.to_i - 1
    end
    input
  end

  def check_user_input?(input)
    input.between?(0,6) && @board.column_empty?(input)
  end

  def drop_disc(input)
    @board.drop_disc(@current_player.disc, input)
    show_board
  end

  def switch_player
    @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
  end

  def game_over?
    if row_check || column_check || diag_backslash || diag_forwardslash
      puts "Game Over, #{@current_player.name} won!"
      true
    elsif @board.board.flatten.include?(@default_piece) == false
      puts "Its a tie!"
      true
    else
      return false
    end
  end

  def row_check
    5.downto(0) do |i|
      # create sub-arrays of each row where every new disc or default piece is a sub-array
      rows = @board.board[i].chunk_while { |x,y| x==y }.to_a 
      rows.each do |x|
        if x.count == 4 && x.include?(@default_piece) == false # check each sub-array
          return true
          exit
        end
      end
    end
    return false
  end

  def column_check
    columns = @board.board.transpose
    0.upto(6) do |i|
      cols = columns[i].chunk_while { |x,y| x==y }.to_a
      cols.each do |x|
        if x.count == 4 && x.include?(@default_piece) == false
          return true
          exit
        end
      end
    end
    return false
  end

  def diag_backslash
    5.downto(3) do |i| # row
      3.upto(6) do |j| # column
        if @board.board[i][j] != @default_piece && @board.board[i][j] == @board.board[i-1][j-1] && @board.board[i][j] == @board.board[i-2][j-2] && @board.board[i][j] == @board.board[i-3][j-3]
          return true
          exit
        end
      end
    end
    return false
  end

  def diag_forwardslash
    5.downto(3) do |i| # row
      3.downto(0) do |j| # column
        if @board.board[i][j] != @default_piece && @board.board[i][j] == @board.board[i-1][j+1] && @board.board[i][j] == @board.board[i-2][j+2] && @board.board[i][j] == @board.board[i-3][j+3]
          return true
          exit
        end
      end
    end
    return false
  end

  def new_game?
    puts "Press any button to exit or type (y) to play a new game: "
    response = gets.chomp
    (response == 'y' || response == 'Y') ? Game.new.play : exit
  end

end

c4 = Game.new
c4.play
