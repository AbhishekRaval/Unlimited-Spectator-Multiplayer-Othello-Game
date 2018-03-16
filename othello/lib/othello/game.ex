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

  def handleTileClick (game, row, column) do

    clickedTile = game.grid[row][column]
    if clickedTile === 0 do  # if current user is on of the players
      newGameState = checkHit(game, clickedTile, row, column)
    else
      newGameState = game
    end
    newGameState

  end


end
