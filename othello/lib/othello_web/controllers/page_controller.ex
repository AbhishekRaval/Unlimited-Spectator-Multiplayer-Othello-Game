defmodule OthelloWeb.PageController do
  use OthelloWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def game(conn,page_params) do
    gamename = page_params["gamename"]
    playername= page_params["playername"]
    options= page_params["options"]
  	if(gamename == "" || playername == "") do
	  	conn
    	|> put_flash(:error, "Can't create session")
    	|> redirect(to: "/")	
  	else  	
        IO.puts(options)
  	    render conn, "game.html", game_name: gamename, player_name: playername, options: options		
  	end
  end

end
