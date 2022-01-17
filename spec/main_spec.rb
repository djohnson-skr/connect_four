require_relative "../lib/main"
require_relative "../lib/board"
require_relative "../lib/player"
require 'colorize'

# Ensure that the #play method is not called when performing testing
# This is to ensure a gets is not called when initializing a new Game below
# gets is not tested as it is a fundamental ruby method
# Supporting methods for the user input from gets are tested

describe Game do
  
  describe "#initialize" do
    game = Game.new
    board = game.board.board

    it "creates an array" do
      expect(board).to be_a(Array)
    end
  end

  describe "#check_user_input?" do
    game = Game.new

    context "Board column is not full" do
      it "accepts 1" do
        input = 1
        expect(game.check_user_input?(input)).to eq true
      end

      it "rejects 8" do
        input = 8
        expect(game.check_user_input?(input)).to eq false
      end
    end

    context "Board column is full" do
      before do
        allow(game.board).to receive(:column_empty?).and_return(false)
      end
      it "rejects 1" do
        input = 1
        expect(game.check_user_input?(input)).to eq false
      end
    end
  end

  describe "#drop_disc" do
    # see board_spec.rb for #drop_disc testing
  end

  describe "switch_player" do
    game = Game.new
    it "switches to player2" do
      expect(game.switch_player).to eq(game.player2)
    end

    it "switches back to player1" do
      expect(game.switch_player).to eq(game.player1)
    end
  end

  describe "#row_check" do
    game = Game.new
    board = game.board.board

    it "no connect 4" do
      board[0] = ['●'.red,'●'.light_yellow,'●'.red,'●'.red,'●'.light_yellow,'●'.light_yellow,'●'.light_yellow,]
      expect(game.row_check).to eq false
    end

    it "row 1" do
      board[5] = ['●'.red,'●'.red,'●'.red,'●'.red,'●'.light_yellow,'●'.light_yellow,'●'.light_yellow,]
      expect(game.row_check).to eq true
    end

    it "row 6" do
      board[0] = ['●'.red,'●'.red,'●'.red,'●'.red,'●'.light_yellow,'●'.light_yellow,'●'.light_yellow,]
      expect(game.row_check).to eq true
    end
  end

  describe "#column_check" do
    game = Game.new
    board = game.board.board

    it "no connect four" do
      for i in (4..5) do
        board[i][2] = '●'.red
      end
      expect(game.column_check).to eq false
    end

    it "connect four" do
      for i in (0..3) do
        board[i][0] = '●'.red
      end
      expect(game.column_check).to eq true
    end

    it "connect four" do
      for i in (2..5) do
        board[i][4] = '●'.red
      end
      expect(game.column_check).to eq true
    end
  end

  describe "#diag_backslash" do
    game = Game.new
    board = game.board.board

    it "no connect four" do
      board[0][4] = '●'.red
      board[1][5] = '●'.red
      board[2][6] = '●'.red
      expect(game.diag_backslash).to eq false
    end

    it "connect four" do
      board[0][3] = '●'.red
      board[1][4] = '●'.red
      board[2][5] = '●'.red
      board[3][6] = '●'.red
      expect(game.diag_backslash).to eq true
    end

    it "connect four" do
      board[2][3] = '●'.red
      board[3][4] = '●'.red
      board[4][5] = '●'.red
      board[5][6] = '●'.red
      expect(game.diag_backslash).to eq true
    end
  end

  describe "#diag_forwardslash" do
    game = Game.new
    board = game.board.board

    it "no connect four" do
      board[5][0] = '●'.red
      board[4][1] = '●'.red
      board[3][2] = '●'.red
      expect(game.diag_forwardslash).to eq false
    end

    it "connect four" do
      board[5][3] = '●'.red
      board[4][4] = '●'.red
      board[3][5] = '●'.red
      board[2][6] = '●'.red
      expect(game.diag_forwardslash).to eq true
    end

    it "connect four" do
      board[3][0] = '●'.red
      board[2][1] = '●'.red
      board[1][2] = '●'.red
      board[0][3] = '●'.red
      expect(game.diag_forwardslash).to eq true
    end
  end
end