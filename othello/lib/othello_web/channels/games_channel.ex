defmodule OthelloWeb.GamesChannel do
  use OthelloWeb, :channel
  alias Othello.Game

  def join("games:" <> game_name, payload, socket) do
    game = Othello.GameBackup.load(game_name) || Game.new
    socket = socket
             |>assign(:game, game)
             |>assign(:game_name, game_name)
    Othello.GameBackup.save(game_name,game)
    if authorized?(payload) do
      #broadcast! socket, "game:new", %{game: game}
      {:ok, %{"game" => game},socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # def handle_in("joining", payload, socket) do
  #   resp = %{ "pn" => payload["pn"] }
  #   IO.puts(resp)
  #   {:reply, {:joined, resp}, socket}
  # end

  def handle_in("player1join", %{"player1" => player1}, socket) do
    game_init = Othello.GameBackup.load(socket.assigns[:game_name])
    game_fn = Game.addPlayer1(game_init, player1)
    Othello.GameBackup.save(socket.assigns[:game_name], game_fn)
    socket = socket|>assign(:game, game_fn)
    broadcast! socket, "player1join", %{"game" => game_fn}
    {:noreply, socket}
    #{:reply, {:ok, %{"game" => game_fn}}, socket}
  end

  def handle_in("sendmsg", %{"msg" => msg}, socket) do
    game_init = Othello.GameBackup.load(socket.assigns[:game_name])
    game_fn = Game.appendmsg(game_init, msg)
    Othello.GameBackup.save(socket.assigns[:game_name], game_fn)
    socket = socket|>assign(:game, game_fn)
    broadcast! socket, "sendmsg", %{"game" => game_fn}
    {:noreply, socket}
    #{:reply, {:ok, %{"game" => game_fn}}, socket}
  end

  def handle_in("player2join", %{"player2" => player2}, socket) do
    game_init = Othello.GameBackup.load(socket.assigns[:game_name])
    game_fn = Game.addPlayer2(game_init, player2)
    Othello.GameBackup.save(socket.assigns[:game_name], game_fn)
    socket = socket|>assign(:game, game_fn)
    broadcast! socket, "player2join", %{"game" => game_fn}
    {:noreply, socket}
    #{:reply, {:ok, %{"game" => game_fn}}, socket}
  end

  def handle_in("leave", %{"player" => player}, socket) do
    game_init = Othello.GameBackup.load(socket.assigns[:game_name])
    game_fn = Game.leave(game_init, player)
    Othello.GameBackup.save(socket.assigns[:game_name], game_fn)
    socket = socket|>assign(:game, game_fn)
    broadcast! socket, "leave", %{"game" => game_fn}
    {:noreply, socket}
    #{:reply, {:ok, %{"game" => game_fn}}, socket}
  end

  def handle_in("reset",payload, socket) do
    game_init = Othello.GameBackup.load(socket.assigns[:game_name])
    game_fn = Game.reset(game_init)
    Othello.GameBackup.save(socket.assigns[:game_name], game_fn)
    socket = socket|>assign(:game, game_fn)
    broadcast! socket, "reset", %{"game" => game_fn}
    {:noreply, socket}
    #{:reply, {:ok, %{"game" => game_fn}}, socket}
  end

 def handle_in("handleclickfn", %{"i" => i, "j" => j}, socket) do
    game_init = Othello.GameBackup.load(socket.assigns[:game_name])
    IO.puts('inspect:')

    game_fn = Game.handleTileClick(game_init,i,j)
    
    IO.inspect(game_fn)
    Othello.GameBackup.save(socket.assigns[:game_name], game_fn)
    socket = socket|>assign(:game, game_fn)
    #attribution: https://medium.com/@Stephanbv/elixir-phoenix-build-a-simple-chat-room-7f20ee8e8f9c
    broadcast! socket, "handleclickfn", %{"game" => game_fn}
    {:noreply, socket}
  end


  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (games:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
