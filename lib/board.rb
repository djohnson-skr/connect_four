class Board
  attr_accessor :board, :default_piece
  
  def initialize()
    @default_piece = "\u25CB".force_encoding('utf-8')
    @board = Array.new(6) { Array.new(7, @default_piece) } # 6 row 7 col matrix
  end

  def column_empty?(column)
    columns = @board.transpose 
    columns[column].include?(@default_piece)
  end

  def drop_disc(disc, selection)
    5.downto(0) do |i|
      if @board[i][selection] == @default_piece
        @board[i][selection] = disc
        break
      end
    end
  end
end
