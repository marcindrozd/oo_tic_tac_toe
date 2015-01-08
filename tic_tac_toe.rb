# Object Oriented Tic Tac Toe

require "pry"

class Human
  attr_accessor :name

  def initialize
    puts "Please enter your name:"
    @name = gets.chomp
  end

  def pick_square(board)
    while true
      puts "Enter the number from the board to make your move:"
      square = gets.chomp
      break if board.square_available?(square)
      puts "You cannot put your mark there! Please enter empty 1-9 field!"
    end
    board.update(square, "X")
  end
end

class Computer
  attr_accessor :name

  def initialize
    puts "Please enter the name for computer player:"
    @name = gets.chomp
  end

  def pick_square(board)
    if two_in_a_row(board).is_a?(String)
      square = two_in_a_row(board)
    else
      square = board.available_squares.sample
    end
    board.update(square, "O")
  end

  # If player has two Xs in a row, computer will pick one to block the win
  def two_in_a_row(board)
    winning_conditions = [[:a, :b, :c], [:d, :e, :f], [:g, :h, :i], [:a, :d, :g],
                      [:b, :e, :h], [:c, :f, :i], [:a, :e, :i], [:c, :e, :g]]
    winning_conditions.each do |line|
      if board.board.values_at(*line).count("X") == 2
        potential_move = []
        line.each do |item|
          potential_move << item if board.board[item] != "X" && board.board[item] != "O"
        end
        return board.board[potential_move.first] if !potential_move.empty?
      else
        false
      end
    end
  end
end

class Board
  attr_accessor :board

  def initialize
    @board = {
              a: "1", b: "2", c: "3", 
              d: "4", e: "5", f: "6", 
              g: "7", h: "8", i: "9"
    }
  end

  # return array of available squares
  def available_squares
    squares = board.values
    squares.delete("X")
    squares.delete("O")
    squares
  end

  # check if board is full
  def full?
    available_squares.empty?
  end

  def draw
    system "clear"
    puts """
           |     |     
        #{board[:a]}  |  #{board[:b]}  |  #{board[:c]}   
           |     |
      -----+-----+-----
           |     |     
        #{board[:d]}  |  #{board[:e]}  |  #{board[:f]}
           |     |
      -----+-----+-----
           |     |     
        #{board[:g]}  |  #{board[:h]}  |  #{board[:i]}
           |     |
      """
  end

  def update(square, mark)
    board[board.key(square)] = mark
  end

  # checks if selected move is valid
  def square_available?(square)
    board.values.include?(square)
  end

  # checks if there is a winner
  def winner?
    (board[:a] == board[:b] && board[:b] == board[:c]) ||
    (board[:d] == board[:e] && board[:e] == board[:f]) ||
    (board[:g] == board[:h] && board[:h] == board[:i]) ||
    (board[:a] == board[:d] && board[:d] == board[:g]) ||
    (board[:b] == board[:e] && board[:e] == board[:h]) ||
    (board[:c] == board[:f] && board[:f] == board[:i]) ||
    (board[:a] == board[:e] && board[:e] == board[:i]) ||
    (board[:c] == board[:e] && board[:e] == board[:g])
  end
end

class Game
  attr_reader :board, :player, :computer
  attr_accessor :current_player

  def initialize
    puts "WELCOME TO TIC * TAC * TOE"
    @player = Human.new
    @computer = Computer.new
  end

  def display_message(current_player, win = false)
    if win == true
      puts "#{current_player} wins!"
    else
      puts "It's a tie!"
    end
  end

  def switch_player
    if @current_player == @player
      @current_player = @computer
    else
      @current_player = @player
    end
  end

  def play
    while true
      board = Board.new
      @current_player = [@player, @computer].sample
      
      while true
        board.draw
        current_player.pick_square(board)
        board.draw
        break if board.winner? == true
        break if board.full?
        switch_player
      end

      display_message(current_player.name, board.winner?)

      puts "Play again? (y/n)"
      response = gets.chomp.downcase
      break if response != "y"
    end
  end
end

tic_tac_toe = Game.new.play
