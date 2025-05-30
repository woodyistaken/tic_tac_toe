require_relative "../lib/main/game"
require_relative "../lib/main/board"

describe Game do
  let(:board) { instance_double(Board) }
  subject(:game) { Game.new(board) }
  describe "#initialize" do
    # no testing needed
  end
  describe "#winner" do
    # test the methods used
  end
  describe "#play" do
    before do
      allow(game).to receive(:puts)
      allow(game).to receive(:play_round)
      allow(board).to receive(:reset_board)
    end
    context "replay game once and stop" do
      before do
        allow(game).to receive(:gets).and_return("n\n", "y\n")
      end
      it "stop game after reply" do
        expect(game).to receive(:play_round).twice
        game.play
      end
    end
    context "replay game 10 times and stop" do
      before do
        allow(game).to receive(:gets).and_return("n\n", "n\n", "n\n", "n\n", "n\n", "n\n", "n\n", "n\n", "n\n", "y\n")
      end
      it "stop game after reply" do
        expect(game).to receive(:play_round).exactly(10).times
        game.play
      end
    end
  end
  describe "#play_round" do
    before do
      allow(game).to receive(:adjust_score)
      allow(game).to receive(:puts)
      allow(board).to receive(:print_board)
      allow(board).to receive(:change_box)
    end
    it "ends if winner is false" do
      allow(game).to receive(:winner).and_return(true)
      expect(game).not_to receive(:get_input)
      game.play_round
    end
    it "play once" do
      allow(game).to receive(:winner).and_return(false, true)
      expect(game).to receive(:get_input).once
      game.play_round
    end
    it "play 10 times" do
      allow(game).to receive(:winner).and_return(false, false, false, false, false, false, false, false, false, false,
                                                 true)
      expect(game).to receive(:get_input).exactly(10).times
      game.play_round
    end
  end

  describe "adjust_score" do
    context "player is X" do
      before do
        game.instance_variable_set(:@player, "X")
      end
      it "Increase X score by 1" do
        expect { game.adjust_score }.to change { game.instance_variable_get(:@x_score) }.by(1)
      end
    end

    context "player is O" do
      before do
        game.instance_variable_set(:@player, "O")
      end
      it "Increase X score by 1" do
        expect { game.adjust_score }.to change { game.instance_variable_get(:@o_score) }.by(1)
      end
    end
  end
  describe "#get_input" do
    before do
      allow(game).to receive(:puts)
      allow(game).to receive(:gets).and_return("")
      allow(board).to receive(:check_box)
    end
    it "stops when check_box is true" do
      allow(board).to receive(:check_box).and_return(true)
      expect(board).to receive(:check_box).once
      game.get_input
    end
    it "loop once then stop" do
      allow(board).to receive(:check_box).and_return(false, true)
      expect(board).to receive(:check_box).twice
      game.get_input
    end
    it "loop 10 times then stop" do
      allow(board).to receive(:check_box).and_return(false, false, false, false, false, false, false, false, false,
                                                     false, true)
      expect(board).to receive(:check_box).exactly(11).times
      game.get_input
    end
  end
end
