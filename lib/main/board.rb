class Board
  def initialize
    @board = Array.new(3) { Array.new(3) { " " } }
  end

  def check_box(row, column, char)
    return false unless %w[X O].include?(char) &&
                        row.between?(0, 2) && column.between?(0, 2) &&
                        @board[row][column] == " "

    true
  end

  def change_box(row, column, char)
    @board[row][column] = char
  end

  def print_board
    puts "    1     2     3"
    3.times do |i|
      puts "#{i + 1}   #{@board[i][0]}  |  #{@board[i][1]}  |  #{@board[i][2]}"
      puts "  -----------------" unless i == 2
    end
  end

  def reset_board
    @board = Array.new(3) { Array.new(3) { " " } }
  end

  def check_diagonal
    return true if @board[1][1] != " " &&
                   ((@board[0][0] == @board[1][1] && @board[1][1] == @board[2][2]) ||
                   (@board[0][2] == @board[1][1] && @board[1][1] == @board[2][0]))

    false
  end

  def check_rows
    3.times do |i|
      return true if @board[i][0] != " " && @board[i][0] == @board[i][1] && @board[i][1] == @board[i][2]
    end
    false
  end

  def check_columns
    3.times do |i|
      return true if @board[0][i] != " " && @board[0][i] == @board[1][i] && @board[1][i] == @board[2][i]
    end
    false
  end
end
