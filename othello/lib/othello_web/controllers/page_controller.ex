defmodule OthelloWeb.PageController do
  use OthelloWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def game(conn, params) do
    render conn, "game.html", game_name: params["game_name"]
  end

end
