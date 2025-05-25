require_relative "board"

class Game
  def initialize
    @board = Board.new
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

  private

  def play_round
    until winner
      @player = @player == "X" ? "O" : "X"
      @board.print_board
      puts "#{@player}'s turn"
      loop do
        puts "Choose a row"
        row = gets.chomp.to_i - 1
        puts "Choose a column"
        column = gets.chomp.to_i - 1

        break if @board.change_box(row, column, @player)

        puts "Invalid input"
      end
    end
    if @player == "X"
      @x_score += 1
    elsif @player == "O"
      @o_score += 1
    end
    @player
  end
end
