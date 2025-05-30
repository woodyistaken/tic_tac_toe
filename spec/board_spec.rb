require_relative "../lib/main/board"

describe Board do
  subject(:board) { described_class.new }
  describe "#initialize" do
    # No testing needed
  end
  describe "#change_box" do
    context "Change valid square" do
      it "change [2,2]" do
        expect { board.change_box(2, 2, "o") }.to change { board.instance_variable_get(:@board)[2][2] }.to("o")
      end
    end
    context "Change invalid square" do
      # input checking makes sure invalid square is not changed
    end
  end
  describe "#check_box" do
    it "return true given valid input" do
      expect(board.check_box(1, 1, "X")).to be true
    end
    it "return false given invalid char" do
      expect(board.check_box(1, 1, "A")).to be false
    end
    it "return false given invalid out of bounds row" do
      expect(board.check_box(4, 1, "X")).to be false
    end
    it "return false given invalid out of bounds column" do
      expect(board.check_box(1, 4, "X")).to be false
    end
    it "return false given occupied square" do
      board.change_box(1, 1, "O")
      expect(board.check_box(1, 1, "X")).to be false
    end
  end
  describe "#print_board" do
    # No testing needed
  end
  describe "#reset_board" do
    it "clear a board" do
      board.change_box(1, 1, "O")
      expect { board.reset_board }.to change { board.instance_variable_get(:@board) }.to(Array.new(3) {
        Array.new(3) do
          " "
        end
      })
    end
  end
  describe "#check_diagonal" do
    context "no valid diagonals" do
      it "return false" do
        expect(board.check_diagonal).to be false
      end
    end
    context "alternating right to left diagonal" do
      before do
        board.change_box(0, 0, "O")
        board.change_box(1, 1, "X")
        board.change_box(2, 2, "O")
      end
      it "return false" do
        expect(board.check_diagonal).to be false
      end
    end
    context "right to left diagonal" do
      before do
        board.change_box(0, 0, "O")
        board.change_box(1, 1, "O")
        board.change_box(2, 2, "O")
      end
      it "return true" do
        expect(board.check_diagonal).to be true
      end
    end
    context "left to right diagonal" do
      before do
        board.change_box(0, 2, "O")
        board.change_box(1, 1, "O")
        board.change_box(2, 0, "O")
      end
      it "return true" do
        expect(board.check_diagonal).to be true
      end
    end
  end
  describe "#check_rows" do
    context "no valid rows" do
      it "return false" do
        expect(board.check_rows).to be false
      end
    end
    context "valid top row" do
      before do
        board.change_box(0, 0, "O")
        board.change_box(0, 1, "O")
        board.change_box(0, 2, "O")
      end
      it "return true" do
        expect(board.check_rows).to be true
      end
    end
    context "valid mid row" do
      before do
        board.change_box(1, 0, "O")
        board.change_box(1, 1, "O")
        board.change_box(1, 2, "O")
      end
      it "return true" do
        expect(board.check_rows).to be true
      end
    end
    context "valid bottom row" do
      before do
        board.change_box(2, 0, "O")
        board.change_box(2, 1, "O")
        board.change_box(2, 2, "O")
      end
      it "return true" do
        expect(board.check_rows).to be true
      end
    end
  end
  describe "#check_columns" do
    context "no valid columns" do
      it "return false" do
        expect(board.check_columns).to be false
      end
    end
    context "valid first column" do
      before do
        board.change_box(0, 0, "O")
        board.change_box(1, 0, "O")
        board.change_box(2, 0, "O")
      end
      it "return true" do
        expect(board.check_columns).to be true
      end
    end
    context "valid second column" do
      before do
        board.change_box(0, 1, "O")
        board.change_box(1, 1, "O")
        board.change_box(2, 1, "O")
      end
      it "return true" do
        expect(board.check_columns).to be true
      end
    end
    context "valid third column" do
      before do
        board.change_box(0, 2, "O")
        board.change_box(1, 2, "O")
        board.change_box(2, 2, "O")
      end
      it "return true" do
        expect(board.check_columns).to be true
      end
    end
  end
end
