// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

import socket from "./socket"
import run_game from "./game";
import swal from "sweetalert";

function init() {
  let channel = socket.channel("games:" + window.gameName, {})
  let root = document.getElementById('game');
  //run_game(root);
  // channel.join()
  //   .receive("ok", resp => { console.log("Joined successfully", resp) })
  //   .receive("error", resp => { console.log("Unable to join", resp) })


  if (!root) {

    $('#game-button').click(() => {
      let gn = $('#game-name').val();
      let pn = $('#player-name').val();
      let cn = $('input[name=options]:checked').val();
      console.log(cn);
      // $('#ahr').attr("href", "/games/"+gn+"/"+pn);
      if (gn == "" || pn == ""){
        swal("Please enter both the game name and the player name!");
      }
      // else{
      //   window.location.href  = "/games/"+gn+"/"+pn;
      //   //run_game(root, channel, pn);
      // }

      //console.log(playerName + "player Name is here : :: : : " + pn )
      // channel.push("joining", { gn: gn, pn: pn }).receive("joined", resp =>
      //   { console.log("Player joined successfully") });
      //
    });
    

    $('#player-name').keypress(function (e) {
      var key = e.which;
      if(key == 13)  // the enter key code
       {
         $('#game-button').click();
         return false;
       }
    });
    $('#game-name').keypress(function (e) {
      var key = e.which;
      if(key == 13)  // the enter key code
       {
         $('#game-button').click();
         return false;
       }
    });

    


  }
  run_game(root, channel);

}

// Use jQuery to delay until page loaded.
$(init);
