# Two players game. Players draw board with 9 empty squares
# Player one picks 'X', player two picks 'O'. Player X picks an empty square and draws X
# Player two picks emtpy square and draws 'O'.
# Players repeat their movement until board is full or one player has 3 his marks in a row
# If board is full and no player has a line of marks, it's a tie. Otherwise 1st player who
# has 3 marks in a row wins.

require "pry"

class Human
  attr_accessor :name

  def initialize
    puts "Please enter your name:"
    self.name = gets.chomp
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
    self.name = gets.chomp
  end

  def pick_square(board)
    available_squares = board.board.values
    available_squares.delete("X")
    available_squares.delete("O")
    square = available_squares.sample
    board.update(square, "O")
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

  def full?
    available_squares = board.values
    available_squares.delete("X")
    available_squares.delete("O")
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

  def square_available?(square)
    board.values.include?(square)
  end

  def winner?
    if (board[:a] == board[:b] && board[:b] == board[:c]) ||
      (board[:d] == board[:e] && board[:e] == board[:f]) ||
      (board[:g] == board[:h] && board[:h] == board[:i]) ||
      (board[:a] == board[:d] && board[:d] == board[:g]) ||
      (board[:b] == board[:e] && board[:e] == board[:h]) ||
      (board[:c] == board[:f] && board[:f] == board[:i]) ||
      (board[:a] == board[:e] && board[:e] == board[:i]) ||
      (board[:c] == board[:e] && board[:e] == board[:g])
      true
    end
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

  def play
    board = Board.new
    
    while true
      board.draw
      current_player = player
      player.pick_square(board)
      board.draw
      break if board.winner? == true
      break if board.full?
      current_player = computer
      computer.pick_square(board)
      board.draw
      break if board.winner? == true
      break if board.full?
    end

    # puts message that says either who won or that there is a tie
    display_message(current_player.name, board.winner?)
  end
end

tic_tac_toe = Game.new.play
