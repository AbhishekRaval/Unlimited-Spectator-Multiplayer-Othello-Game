defmodule othello.Game do
  def new do
    %{
      p1_turn: true,
      grid: init(),
      p1: nil,
      p2: nil,
      p1score: 0,
      p2score: 0
    }
  end

  def init() do
     %{
        0 => %{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0, 7 => 0},
        1 => %{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0, 7 => 0},
        2 => %{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0, 7 => 0},
        3 => %{0 => 0, 1 => 0, 2 => 0, 3 => 2, 4 => 1, 5 => 0, 6 => 0, 7 => 0},
        4 => %{0 => 0, 1 => 0, 2 => 0, 3 => 1, 4 => 2, 5 => 0, 6 => 0, 7 => 0},
        5 => %{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0, 7 => 0},
        6 => %{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0, 7 => 0},
        7 => %{0 => 0, 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0, 7 => 0}
      }
  end

  def handleTileClick (game, row, column, pn) do

    clickedTile = game.grid[row][column]
    if clickedTile === 0 and isValid(game, row, column)do  # if current user is on of the players TODO
      if pn === game.p1 or pn === game.p2 do
          newGameState = checkHit(game, clickedTile, row, column)
      end
    else
      newGameState = game
    end
    newGameState

  end

  def isValid(game, row, column) do

    checkUp(game, row, column)
    or checkDown(game, row, column)
    or checkLeft(game, row, column)
    or checkRight(game, row, column)
    or checkLeftUp(game, row, column)
    or checkRightUp(game, row, column)
    or checkLeftDown(game, row, column)
    or checkRightDown(game, row, column)

  end

  def checkRightUp() do

  end

  def checkRightDown() do

  end

  def checkLeftUp() do

  end

  def checkLeftDown() do

  end

  def checkRight() do

  end

  def checkLeft() do

  end

  def checkUp() do

  end

  def checkDown() do

  end


  ##
# cases:
# if diagonal-right-up block has diff value
# if diagonal-left-up block has diff value
# if diagonal-right-down block has diff value
# if diagonal-left-down block has diff value
#

  ##

  def checkHit(game, clickedTile, row, column) do

  end



end
