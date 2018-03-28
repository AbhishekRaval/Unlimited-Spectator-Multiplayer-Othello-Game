defmodule OthelloWeb.PageController do
  use OthelloWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def game(conn, %{"gamename"=>gamename,"playername"=>playername}) do
  	if(gamename == "" || playername == "") do
	  	conn
    	|> put_flash(:error, "Can't create session")
    	|> redirect(to: "/")	
  	else  	
  	    render conn, "game.html", game_name: gamename, player_name: playername		
  	end
  end

end
