defmodule OthelloWeb.GamesChannel do
  use OthelloWeb, :channel
  alias Othello.Game

  def join("games:" <> game_name, payload, socket) do
    if authorized?(payload) do
      {:ok, %{"game" => Game.new()},socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  def handle_in("joining", payload, socket) do
    resp = %{ "pn" => payload["pn"] }
    {:reply, {:joined, resp}, socket}
  end

 def handle_in("handleclickfn", %{"i" => i, "j" => j, "pn" => pn}, socket) do
    game_init = socket.assigns[:game]
    game_fn = Game.handleTileClick(game_init,i,j,pn)
    socket = socket|>assign(:game, game_fn)
    {:reply, {:ok, %{"game" => Game.client_view(game_fn)}}, socket}
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
