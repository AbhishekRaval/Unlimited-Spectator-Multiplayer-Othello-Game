defmodule OthelloWeb.GamesChannel do
  use OthelloWeb, :channel

  def join("games:" <> game_name, payload, socket) do
    if authorized?(payload) do
      {:ok, %{"join" => game_name},socket}
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
