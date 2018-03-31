defmodule Othello.Game do
  def new do
    %{
      p1_turn: true,
      grid: init(),
      p1: nil,
      p2: nil,
      p1score: 0,
      p2score: 0,
      msg: [],
      winner: 0 
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

  def handleTileClick(game, row, column) do

    newGameState = game

    clickedTile = game.grid[row][column]
    # IO.puts("clickedTile")
    # IO.inspect(clickedTile)
    if game.p1 !== nil and game.p2 !== nil do
      # IO.puts("game")
      # IO.inspect(game)
      if (clickedTile === 0 or clickedTile === 3) and isValid(game, row, column) do
        # IO.puts('anyting')
        newGameState = checkHit(game, row, column)
        newGameState = %{newGameState | p1_turn: !newGameState.p1_turn}
        newGameState = checkforWinner(newGameState)
        newGameState = getvalidtiles(newGameState)
      end
    end
    newGameState

  end

  def isValid(game, row, column) do
      if game.grid[row][column] !== 1 and game.grid[row][column] !== 2 do
        result = false
        if game.p1_turn do
          if game.grid[row-1][column] === 1 do
            result = result or checkUp(game, row, column)
          end
          if game.grid[row+1][column] === 1 do
            result = result or checkDown(game, row, column)
          end
          if game.grid[row][column-1] === 1 do
            result = result or checkLeft(game, row, column)
          end
          if game.grid[row][column+1] === 1 do
            result = result or checkRight(game, row, column)
          end
          if game.grid[row-1][column-1] === 1 do
            result = result or checkLeftUp(game, row, column)
          end
          if game.grid[row-1][column+1] === 1 do
            result = result or checkRightUp(game, row, column)
          end
          if game.grid[row+1][column-1] === 1 do
            result = result or checkLeftDown(game, row, column)
          end
          if game.grid[row+1][column+1] === 1 do
            result = result or checkRightDown(game, row, column)
          end
        else
          if game.grid[row-1][column] === 2 do
            result = result or checkUp(game, row, column)
          end
          if game.grid[row+1][column] === 2 do
            result = result or checkDown(game, row, column)
          end
          if game.grid[row][column-1] === 2 do
            result = result or checkLeft(game, row, column)
          end
          if game.grid[row][column+1] === 2 do
            result = result or checkRight(game, row, column)
          end
          if game.grid[row-1][column-1] === 2 do
            result = result or checkLeftUp(game, row, column)
          end
          if game.grid[row-1][column+1] === 2 do
            result = result or checkRightUp(game, row, column)
          end
          if game.grid[row+1][column-1] === 2 do
            result = result or checkLeftDown(game, row, column)
          end
          if game.grid[row+1][column+1] === 2 do
            result = result or checkRightDown(game, row, column)
          end
      end
    end
    result

  end

  def checkRightUp(game, row, column) do


    if game.p1_turn do
      if column < 7 and row > 0 do
        if game.grid[row-1][column+1] === 1 do
          retVal = checkRightUp(game, row-1, column+1)
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
          retVal = checkRightUp(game, row-1, column+1)
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


    if game.p1_turn do
      if column < 7 and row < 7 do
        if game.grid[row+1][column+1] === 1 do
          retVal = checkRightDown(game, row+1, column+1)
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
          retVal = checkRightDown(game, row+1, column+1)
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


    if game.p1_turn do
      if column > 0 and row > 0 do
        if game.grid[row-1][column-1] === 1 do
          retVal = checkLeftUp(game, row-1, column-1)
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
          retVal = checkLeftUp(game, row-1, column-1)
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


    if game.p1_turn do
      if column > 0 and row < 7 do
        if game.grid[row+1][column-1] === 1 do
          retVal = checkLeftDown(game, row+1, column-1)
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
          retVal = checkLeftDown(game, row+1, column-1)
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


    if game.p1_turn do
      if column < 7 do
        if game.grid[row][column+1] === 1 do
          retVal = checkRight(game, row, column+1)
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
          retVal = checkRight(game, row, column+1)
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


    if game.p1_turn do
      if column > 0 do
        if game.grid[row][column-1] === 1 do
          retVal = checkLeft(game, row, column-1)
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
      if column > 0 do
        if game.grid[row][column-1] === 2 do
          retVal = checkLeft(game, row, column-1)
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


    if game.p1_turn do
      if row > 0 do
        if game.grid[row-1][column] === 1 do
          retVal = checkUp(game, row-1, column)
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
      if row > 0 do
        if game.grid[row-1][column] === 2 do
          retVal = checkUp(game, row-1, column)
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

  def checkDown(game, row, column) do


    if game.p1_turn do
      if row < 7 do
        if game.grid[row+1][column] === 1 do
          retVal = checkDown(game, row+1, column)
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
      if row < 7 do
        if game.grid[row+1][column] === 2 do
          retVal = checkDown(game, row+1, column)
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

  def checkHit(game, row, column) do

    if checkUp(game, row, column) do
      game = checkHitUp(game, row,column)
    end
    if checkDown(game, row, column) do
      game = checkHitDown(game, row,column)
    end
    if checkLeft(game, row, column) do
      game = checkHitLeft(game, row,column)
    end
    if checkRight(game, row, column) do
      game = checkHitRight(game, row,column)
    end
    if checkLeftUp(game, row, column) do
      game = checkHitLeftUp(game, row,column)
    end
    if checkLeftDown(game, row, column) do
      game = checkHitLeftDown(game, row,column)
    end
    if checkRightUp(game, row, column) do
      game = checkHitRightUp(game, row,column)
    end
    if checkRightDown(game, row, column) do
      game = checkHitRightDown(game, row,column)
    end
    countScore(game)

  end

  def checkHitUp(game, row,column) do


    if game.p1_turn do
      game = put_in(game.grid[row][column], 2)
      if row > 0 do
        if game.grid[row-1][column] === 1 do
          newGameVal = checkHitUp(game, row-1, column)
        else
          if game.grid[row-1][column] === 2 do
            newGameVal = game
          else
            newGameVal = game
          end
        end
      else
        newGameVal = game
      end
    else
      game = put_in(game.grid[row][column], 1)
      if row > 0 do
        if game.grid[row-1][column] === 2 do
          newGameVal = checkHitUp(game, row-1, column)
        else
          if game.grid[row-1][column] === 1 do
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


  def checkHitDown(game, row, column) do


    if game.p1_turn do
      game = put_in(game.grid[row][column], 2)
      if row < 7 do
        if game.grid[row+1][column] === 1 do
          newGameVal = checkHitDown(game, row+1, column)
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
      game = put_in(game.grid[row][column], 1)
      if row < 7 do
        if game.grid[row+1][column] === 2 do
          newGameVal = checkHitDown(game, row+1, column)
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

  def checkHitLeft(game, row,column) do


    if game.p1_turn do
      game = put_in(game.grid[row][column], 2)
      if column > 0 do
        if game.grid[row][column-1] === 1 do
          newGameVal = checkHitLeft(game, row, column-1)
        else
          if game.grid[row][column-1] === 2 do
            newGameVal = game
          else
            newGameVal = game
          end
        end
      else
        newGameVal = game
      end
    else
      game = put_in(game.grid[row][column], 1)
      if column > 0 do
        if game.grid[row][column-1] === 2 do
          newGameVal = checkHitLeft(game, row, column-1)
        else
          if game.grid[row][column-1] === 1 do
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

  def checkHitRight(game, row,column) do


    if game.p1_turn do
      game = put_in(game.grid[row][column], 2)
      if column < 7 do
        if game.grid[row][column+1] === 1 do
          newGameVal = checkHitRight(game, row, column+1)
        else
          if game.grid[row][column+1] === 2 do
            newGameVal = game
          else
            newGameVal = game
          end
        end
      else
        newGameVal = game
      end
    else
      game = put_in(game.grid[row][column], 1)
      if column < 7 do
        if game.grid[row][column+1] === 2 do
          newGameVal = checkHitRight(game, row, column+1)
        else
          if game.grid[row][column+1] === 1 do
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


  def checkHitRightDown(game, row,column) do


    if game.p1_turn do
      game = put_in(game.grid[row][column], 2)
      if column < 7 and row < 7 do
        if game.grid[row+1][column+1] === 1 do
          newGameVal = checkHitRightDown(game, row+1, column+1)
        else
          if game.grid[row+1][column+1] === 2 do
            newGameVal = game
          else
            newGameVal = game
          end
        end
      else
        newGameVal = game
      end
    else
      game = put_in(game.grid[row][column], 1)
      if column < 7 and row < 7 do
        if game.grid[row+1][column+1] === 2 do
          newGameVal = checkHitRightDown(game, row+1, column+1)
        else
          if game.grid[row+1][column+1] === 1 do
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

  def checkHitRightUp(game, row,column) do


    if game.p1_turn do
      game = put_in(game.grid[row][column], 2)
      if column < 7 and row > 0 do
        if game.grid[row-1][column+1] === 1 do
          newGameVal = checkHitRightUp(game, row-1, column+1)
        else
          if game.grid[row-1][column+1] === 2 do
            newGameVal = game
          else
            newGameVal = game
          end
        end
      else
        newGameVal = game
      end
    else
      game = put_in(game.grid[row][column], 1)
      if column < 7 and row > 0 do
        if game.grid[row-1][column+1] === 2 do
          newGameVal = checkHitRightUp(game, row-1, column+1)
        else
          if game.grid[row-1][column+1] === 1 do
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

  def checkHitLeftDown(game, row,column) do


    if game.p1_turn do
      game = put_in(game.grid[row][column], 2)
      if column > 0 and row < 7 do
        if game.grid[row+1][column-1] === 1 do
          newGameVal = checkHitLeftDown(game, row+1, column-1)
        else
          if game.grid[row+1][column-1] === 2 do
            newGameVal = game
          else
            newGameVal = game
          end
        end
      else
        newGameVal = game
      end
    else
      game = put_in(game.grid[row][column], 1)
      if column > 0 and row < 7 do
        if game.grid[row+1][column-1] === 2 do
          newGameVal = checkHitLeftDown(game, row+1, column-1)
        else
          if game.grid[row+1][column-1] === 1 do
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

  def checkHitLeftUp(game, row,column) do


    if game.p1_turn do
      game = put_in(game.grid[row][column], 2)
      if column > 0 and row > 0 do
        if game.grid[row-1][column-1] === 1 do
          newGameVal = checkHitLeftUp(game, row-1, column-1)
        else
          if game.grid[row-1][column-1] === 2 do
            newGameVal = game
          else
            newGameVal = game
          end
        end
      else
        newGameVal = game
      end
    else
      game = put_in(game.grid[row][column], 1)
      if column > 0 and row > 0 do
        if game.grid[row-1][column-1] === 2 do
          newGameVal = checkHitLeftUp(game, row-1, column-1)
        else
          if game.grid[row-1][column-1] === 1 do
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

  def countScore(game) do

    blackc = Enum.sum(Enum.map(game.grid, fn{k,v} ->
        (Enum.count(Map.values(v), fn(key) ->
                  key === 1 end)) end))
    whitec = Enum.sum(Enum.map(game.grid, fn{k,v} ->
        (Enum.count(Map.values(v), fn(key) ->
                  key === 2 end)) end))
    %{
              p1_turn: game.p1_turn,
              grid: game.grid,
              p1: game.p1,
              p2: game.p2,
              p1score: whitec,
              p2score: blackc,
              msg: game.msg,
              winner: game.winner
            }

  end

  def addPlayer1(game, player1) do
    %{game | p1: player1}
  end

  def addPlayer2(game, player2) do
    %{game | p2: player2}
  end


  def getvalidtiles(game) do

    gl = Enum.into(Enum.map(game.grid, fn({k,v}) ->
            {k,
          Enum.into(Enum.map(v, fn({key,value}) ->
            if isValid(game,k,key) do
                 {key, 3}
            else
              if game.grid[k][key] === 1 or game.grid[k][key] === 2 do
                {key, game.grid[k][key]}
              else
                {key, 0}
              end
            end
          end), %{})}
        end), %{})
     %{game | grid: gl}

  end

  def appendmsg(game, msg) do
    msgupdate = [msg | game.msg]
    %{game | msg: msgupdate}
  end

  def checkforWinner(game) do

    if game.p1_turn do
      g = getvalidtiles(game)
      wc = Enum.sum(Enum.map(g.grid, fn{k,v} ->
          (Enum.count(Map.values(v), fn(key) ->
                    key === 3 end)) end))
      if wc === 0 do
        game = %{game | p1_turn: false}
        g = getvalidtiles(game)
        blc = Enum.sum(Enum.map(g.grid, fn{k,v} ->
            (Enum.count(Map.values(v), fn(key) ->
                      key === 3 end)) end))
        if blc === 0 do
          if game.p1score > game.p2score do
            game = %{g | winner: 1}
          else
            game = %{g | winner: 2}
          end
        end
      end
    else
      g = getvalidtiles(game)
      blc = Enum.sum(Enum.map(g.grid, fn{k,v} ->
          (Enum.count(Map.values(v), fn(key) ->
                    key === 3 end)) end))
      if blc === 0 do
        game = %{game | p1_turn: true}
        g = getvalidtiles(game)
        wc = Enum.sum(Enum.map(g.grid, fn{k,v} ->
            (Enum.count(Map.values(v), fn(key) ->
                      key === 3 end)) end))
        if wc === 0 do
          if game.p1score > game.p2score do
            game = %{g | winner: 1}
          else
            game = %{g | winner: 2}
          end
        end
      end
    end
    game

  end

  def leave(game, player) do

    if game.p1 === player do
      game = %{game | p1: nil}
    else
      game = %{game | p2: nil}
    end
    game

  end

  def reset(game) do
    %{game | grid: init(), p1score: 0, p2score: 0, p1_turn: true, winner: 0}
  end

end

# %{
#   0 => %{0 => 0, 1 => 0, 2 => 2, 3 => 2, 4 => 1, 5 => 0, 6 => 2, 7 => 2},
#   1 => %{0 => 1, 1 => 2, 2 => 2, 3 => 2, 4 => 2, 5 => 2, 6 => 2, 7 => 2},
#   2 => %{0 => 2, 1 => 2, 2 => 2, 3 => 2, 4 => 2, 5 => 2, 6 => 2, 7 => 2},
#   3 => %{0 => 2, 1 => 2, 2 => 2, 3 => 2, 4 => 2, 5 => 2, 6 => 2, 7 => 2},
#   4 => %{0 => 2, 1 => 2, 2 => 2, 3 => 2, 4 => 2, 5 => 2, 6 => 2, 7 => 2},
#   5 => %{0 => 2, 1 => 2, 2 => 2, 3 => 2, 4 => 2, 5 => 2, 6 => 2, 7 => 2},
#   6 => %{0 => 2, 1 => 2, 2 => 1, 3 => 2, 4 => 2, 5 => 2, 6 => 2, 7 => 2},
#   7 => %{0 => 2, 1 => 2, 2 => 0, 3 => 2, 4 => 2, 5 => 2, 6 => 2, 7 => 2}
# }
