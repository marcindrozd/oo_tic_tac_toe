# Two players game. Players draw board with 9 empty squares
# Player one picks 'X', player two picks 'O'. Player X picks an empty square and draws X
# Player two picks emtpy square and draws 'O'.
# Players repeat their movement until board is full or one player has 3 his marks in a row
# If board is full and no player has a line of marks, it's a tie. Otherwise 1st player who
# has 3 marks in a row wins.

Player
pick_square

Board
check_if_board_full

Mark
draw

Game
