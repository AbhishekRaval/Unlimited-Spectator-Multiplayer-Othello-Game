defmodule OthelloWeb.PageController do
  use OthelloWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
