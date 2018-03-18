defmodule Othello.Game do
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

  def handleTileClick(game, row, column, pn) do

    clickedTile = game.grid[row][column]
    if pn === game.p1 or pn === game.p2 do
      if clickedTile === 0 and isValid(game, row, column) do
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

  def checkRightUp(game, row, column) do

    retVal = false
    if game.p1_turn do
      if column < 7 and row > 0 do
        if game.grid[row-1][column+1] === 1 do
          checkLeftUp(game, row-1, column+1)
        else
          if game.grid[row-1][column+1] === 2 do
            retVal = true
          else
            retVal = false
          end
        end
      else
        retVal = false
      end
    else
      if column < 7 and row > 0 do
        if game.grid[row-1][column+1] === 2 do
          checkLeftUp(game, row-1, column+1)
        else
          if game.grid[row-1][column+1] === 1 do
            retVal = true
          else
            retVal = false
          end
        end
      else
        retVal = false
      end
    end
    retVal


  end

  def checkRightDown(game, row, column) do

    retVal = false
    if game.p1_turn do
      if column < 7 and row < 7 do
        if game.grid[row+1][column+1] === 1 do
          checkLeftUp(game, row+1, column+1)
        else
          if game.grid[row+1][column+1] === 2 do
            retVal = true
          else
            retVal = false
          end
        end
      else
        retVal = false
      end
    else
      if column < 7 and row < 7 do
        if game.grid[row+1][column+1] === 2 do
          checkLeftUp(game, row+1, column+1)
        else
          if game.grid[row+1][column+1] === 1 do
            retVal = true
          else
            retVal = false
          end
        end
      else
        retVal = false
      end
    end
    retVal


  end

  def checkLeftUp(game, row, column) do

    retVal = false
    if game.p1_turn do
      if column > 0 and row > 0 do
        if game.grid[row-1][column-1] === 1 do
          checkLeftUp(game, row-1, column-1)
        else
          if game.grid[row-1][column-1] === 2 do
            retVal = true
          else
            retVal = false
          end
        end
      else
        retVal = false
      end
    else
      if column > 0 and row > 0 do
        if game.grid[row-1][column-1] === 2 do
          checkLeftUp(game, row-1, column-1)
        else
          if game.grid[row-1][column-1] === 1 do
            retVal = true
          else
            retVal = false
          end
        end
      else
        retVal = false
      end
    end
    retVal

  end

  def checkLeftDown(game, row, column) do

    retVal = false
    if game.p1_turn do
      if column > 0 and row < 7 do
        if game.grid[row+1][column-1] === 1 do
          checkLeftUp(game, row+1, column-1)
        else
          if game.grid[row+1][column-1] === 2 do
            retVal = true
          else
            retVal = false
          end
        end
      else
        retVal = false
      end
    else
      if column > 0 and row < 7 do
        if game.grid[row+1][column-1] === 2 do
          checkLeftUp(game, row+1, column-1)
        else
          if game.grid[row+1][column-1] === 1 do
            retVal = true
          else
            retVal = false
          end
        end
      else
        retVal = false
      end
    end
    retVal

  end

  def checkRight(game, row, column) do

    retVal = false
    if game.p1_turn do
      if column < 7 do
        if game.grid[row][column+1] === 1 do
          checkLeftUp(game, row, column+1)
        else
          if game.grid[row][column+1] === 2 do
            retVal = true
          else
            retVal = false
          end
        end
      else
        retVal = false
      end
    else
      if column < 7 do
        if game.grid[row][column+1] === 2 do
          checkLeftUp(game, row, column+1)
        else
          if game.grid[row][column+1] === 1 do
            retVal = true
          else
            retVal = false
          end
        end
      else
        retVal = false
      end
    end
    retVal

  end

  def checkLeft(game, row, column) do

    retVal = false
    if game.p1_turn do
      if column < 7 do
        if game.grid[row][column-1] === 1 do
          checkLeftUp(game, row, column-1)
        else
          if game.grid[row][column-1] === 2 do
            retVal = true
          else
            retVal = false
          end
        end
      else
        retVal = false
      end
    else
      if column < 7 do
        if game.grid[row][column-1] === 2 do
          checkLeftUp(game, row, column-1)
        else
          if game.grid[row][column-1] === 1 do
            retVal = true
          else
            retVal = false
          end
        end
      else
        retVal = false
      end
    end
    retVal

  end

  def checkUp(game, row, column) do

    retVal = false
    if game.p1_turn do
      if column < 7 do
        if game.grid[row+1][column] === 1 do
          checkLeftUp(game, row+1, column)
        else
          if game.grid[row+1][column] === 2 do
            retVal = true
          else
            retVal = false
          end
        end
      else
        retVal = false
      end
    else
      if column < 7 do
        if game.grid[row+1][column] === 2 do
          checkLeftUp(game, row+1, column)
        else
          if game.grid[row+1][column] === 1 do
            retVal = true
          else
            retVal = false
          end
        end
      else
        retVal = false
      end
    end
    retVal

  end

  def checkDown(game, row, column) do

    retVal = false
    if game.p1_turn do
      if column < 7 do
        if game.grid[row-1][column] === 1 do
          checkLeftUp(game, row-1, column)
        else
          if game.grid[row-1][column] === 2 do
            retVal = true
          else
            retVal = false
          end
        end
      else
        retVal = false
      end
    else
      if column < 7 do
        if game.grid[row-1][column] === 2 do
          checkLeftUp(game, row-1, column)
        else
          if game.grid[row-1][column] === 1 do
            retVal = true
          else
            retVal = false
          end
        end
      else
        retVal = false
      end
    end
    retVal

  end

  def checkHit(game, clickedTile, row, column) do

    if checkUp(game, row, column) do
      game = checkHitUp(game, row,column)
    end
    # if checkDown(game, row, column) do
    #   game = checkHitDown(game, row,column)
    # end
    # if checkLeft(game, row, column) do
    #   game = checkHitLeft(game, row,column)
    # end
    # if checkRight(game, row, column) do
    #   game = checkHitRight(game, row,column)
    # end
    # if checkLeftUp(game, row, column) do
    #   game = checkHitLeftUp(game, row,column)
    # end
    # if checkLeftDown(game, row, column) do
    #   game = checkHitLeftDown(game, row,column)
    # end
    # if checkRightUp(game, row, column) do
    #   game = checkHitRightUp(game, row,column)
    # end
    # if checkRightDown(game, row, column) do
    #   game = checkHitRightDown(game, row,column)
    # end

  end

  def checkHitUp(game, row,column) do
    newGameVal = game
    if game.p1_turn do
      if column < 7 do
        if game.grid[row+1][column] === 1 do
          checkLeftUp(game, row+1, column)

          newGameVal = %{
              p1_turn: game.p1_turn,
              grid: put_in(game.grid[row+1][column], 2),
              p1: game.p1,
              p2: game.p2,
              p1score: game.p1score,
              p2score: game.p2score
            }
        else
          if game.grid[row+1][column] === 2 do
            newGameVal = game
          else
            newGameVal = game
          end
        end
      else
        newGameVal = game
      end
    else
      if column < 7 do
        if game.grid[row+1][column] === 2 do
          checkLeftUp(game, row+1, column)
          newGameVal = %{
              p1_turn: game.p1_turn,
              grid: put_in(game.grid[row+1][column], 1),
              p1: game.p1,
              p2: game.p2,
              p1score: game.p1score,
              p2score: game.p2score
            }

        else
          if game.grid[row+1][column] === 1 do
            newGameVal = game
          else
            newGameVal = game
          end
        end
      else
        newGameVal = game
      end
    end
    newGameVal
  end

end
