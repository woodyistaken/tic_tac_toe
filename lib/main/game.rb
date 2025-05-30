require_relative "board"

class Game
  def initialize(board = Board.new)
    @board = board
    @x_score = 0
    @o_score = 0
  end

  def winner
    @board.check_diagonal || @board.check_rows || @board.check_columns
  end

  def play
    loop do
      puts "#{play_round} won the round"
      puts "X: #{@x_score}  O: #{@o_score}"
      puts "Stop playing?(y/n)"
      break if gets.chomp.downcase == "y"

      @board.reset_board
    end
  end

  def play_round
    until winner
      @player = @player == "X" ? "O" : "X"
      @board.print_board
      puts "#{@player}'s turn"
      row, column = get_input
      @board.change_box(row, column, @player)
    end
    adjust_score
    @player
  end

  def adjust_score
    if @player == "X"
      @x_score += 1
    elsif @player == "O"
      @o_score += 1
    end
  end

  def get_input
    row = "", column = ""
    loop do
      puts "Choose a row"
      row = gets.chomp.to_i - 1
      puts "Choose a column"
      column = gets.chomp.to_i - 1

      break if @board.check_box(row, column, @player)

      puts "Invalid input"
    end
    [row, column]
  end
end
