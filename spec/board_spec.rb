require_relative '../lib/board'
require 'colorize'

describe Board do
  context "Create a board" do
    board = Board.new

    it "creates a default piece (open slot)" do
      expect(board.default_piece).to eq("\u25CB".force_encoding('utf-8'))
    end

    it "creates an array of 6x7" do
      expect(board.board.size).to eq(6)
      expect(board.board[0].size).to eq(7)
    end
  end

  context "#column_empty?" do
    board = Board.new
    
    it "column is empty" do
      expect(board.column_empty?(0)).to eq true
    end
    
    it "column is full" do
      # fill the first column
      for i in (0..5) do
        board.board[i][0] = '●'.red
      end
      expect(board.column_empty?(0)).to eq false
    end
  end

  context "#drop_disc" do
    board = Board.new

    it "drop disc in to last row, first column position" do
      board.drop_disc('●'.red,0)
      expect(board.board[5][0]).to eq('●'.red)
    end
  end
end