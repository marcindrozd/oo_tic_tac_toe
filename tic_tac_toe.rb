# Two players game. Players draw board with 9 empty squares
# Player one picks 'X', player two picks 'O'. Player X picks an empty square and draws X
# Player two picks emtpy square and draws 'O'.
# Players repeat their movement until board is full or one player has 3 his marks in a row
# If board is full and no player has a line of marks, it's a tie. Otherwise 1st player who
# has 3 marks in a row wins.

class Player
  attr_accessor :name

  def initialize
  end

  def enter_name(who)
    puts "Please enter name for the #{who}:"
    name = gets.chomp
  end
end

class Human < Player
end

class Computer < Player
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

  def update
  end
end

class Mark
  def draw
  end
end

class Game
  attr_reader :board

  def initialize
    puts "TIC * TAC * TOE"
    @board = Board.new
    @player = Player.new
  end

  def play
    board = Board.new
    board.draw
  end
end

tic_tac_toe = Game.new.play
