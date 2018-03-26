import React from "react";
import ReactDOM from "react-dom";
import { Button } from "reactstrap";
import { Progress } from "reactstrap";
import { Table } from "reactstrap";
//chatfeed api attribution: https://github.com/brandonmowat/react-chat-ui/tree/message-groups/src/ChatBubble
import { ChatFeed, Message } from 'react-chat-ui';
//declare var pName;
//sweetalert api used for customizing alertboxes attribution:https://github.com/t4t5/sweetalert
import swal from 'sweetalert'

export default function run_game(root, channel) { ReactDOM.render( <Layout channel = {channel} />, root)}

class Layout extends React.Component {
  constructor(props) {
    super(props);
    this.channel = props.channel;
    this.channel.join()
      .receive("ok", this.gotView.bind(this))
      .receive("error", resp => {
      console.log("Unable to join, failed", resp);
    });

    this.channel.on("handleclickfn",payload=>
    {let game = payload.game;
    this.setState(game)
        let count =0;
    Object.keys(game.grid).map((cardrow, rowindex) =>
                                ( Object.keys(game.grid[cardrow]).map((card, i) =>
                                                                    ( game.grid[cardrow][card] == 3 ? count+1:count))));

    let noMovePlayer = (game.p1_turn)?game.p2:game.p1;

    if (count==0 && ((this.state.p1 == window.playerName) || (this.state.p2 == window.playerName)) && this.state.winner == 0) {
      console.log("Idhar hai ye B****Ka");
      swal("No valid moves left for", noMovePlayer);
      //swal("No valid moves left for" + noMovePlayer);
    }
    else if((this.state.winner == 1) || (this.state.winner == 2)){
      console.log(this.state.winner)
      this.state.winner==1? swal({
                                  title: "THE WINNER IS.." + this.state.p1,
                                  text: "",
                                  icon: "success",
                                  buttons: true,
                                  dangerMode: true,
                                })
                                .then((willDelete) => {
                                  if (willDelete) {
                                    this.channel
                                  .push("reset")
                                  .receive("ok", this.gotView.bind(this));
                                  }
                                })
                                :this.state.winner==2?
                                swal({
                                      title: "THE WINNER IS.." + this.state.p1,
                                      text: "",
                                      icon: "success",
                                      buttons: true,
                                      dangerMode: true,
                                    })
                                    .then((willDelete) => {
                                      if (willDelete) {
                                        this.channel
                                      .push("reset")
                                      .receive("ok", this.gotView.bind(this));
                                      }
                                    })
                                    :"";
    }


  });

    this.channel.on("player1join",payload=>
    {let game = payload.game;
    this.setState(game)});

    this.channel.on("sendmsg",payload=>
    {let game = payload.game;
      console.log(game);
    this.setState(game)});


    this.channel.on("player2join",payload=>
    {let game = payload.game;
    this.setState(game)});

    this.channel.on("leave",payload=>
    {let game = payload.game;
    this.setState(game)});

    this.channel.on("reset",payload=>
    {let game = payload.game;
    this.setState(game)});

    this.handleChange = this.handleChange.bind(this);
    this.keyPress = this.keyPress.bind(this);
    this.onMessageSubmit = this.onMessageSubmit.bind(this);

    this.state = {
      p1_turn: true,
      grid: [],
      p1: null,
      p2:null,
      p1score: 0,
      p2score: 0,
      msg: [],
      winner: 0
    };
  }


  gotView(msg) {
    console.log("Got View", msg);
    this.setState(msg.game);
  }


   handleChange(e) {
        const input = e.target.value;
   }

   keyPress(e){
     const input = e.target.value;
      if(e.keyCode == 13){
        if(!(input == ""))
        {
          this.onMessageSubmit(input, e);
        }
      }
   }

  onMessageSubmit(txt,e) {
    const input = txt;
    console.log(input)
    let msg = {id: ((this.state.msg.length) + 2), message: input, senderName: window.playerName};
    this.channel.push("sendmsg",{msg: msg})
         .receive("ok",this.gotView.bind(this));
    e.target.value = '';
  }


  p1join(){

        console.log("You pressed OK!");
        this.channel
      .push("player1join", {player1: window.playerName})
      .receive("ok", this.gotView.bind(this));
      swal({
        title: "Great!",
        text: "You joined as Player1!",
        icon: "success",
        button: "Play!",
      });

  }

  p2join(){

        console.log("You pressed OK!");
        this.channel
      .push("player2join", {player2: window.playerName})
      .receive("ok", this.gotView.bind(this));
      swal({
        title: "Great!",
        text: "You joined as Player2!",
        icon: "success",
        button: "Play!",
      });
  }

  leave(){
    swal({
          title: "Are you sure?",
          text: "You want to leave the game?",
          icon: "warning",
          buttons: true,
          dangerMode: true,
        })
        .then((willDelete) => {
          if (willDelete) {
            swal("You are no longer playing the game!", {
              icon: "success",
            });
            if ((this.state.p1 == window.playerName) || (this.state.p2 == window.playerName)){
              console.log("You pressed OK!");
               this.channel
             .push("leave", {player: window.playerName})
             .receive("ok", this.gotView.bind(this));
           }
           window.location.href  = "/"

          } else {

          }
        });



    // if (confirm("Are you sure, you want to leave the game?")){
    //   if ((this.state.p1 == window.playerName) || (this.state.p2 == window.playerName)){
    //     console.log("You pressed OK!");
    //      this.channel
    //    .push("leave", {player: window.playerName})
    //    .receive("ok", this.gotView.bind(this));
    //  }
    //  window.location.href  = "/"
    // }
  }

  leaveCurrentGame(){
        swal({
              title: "Are you sure?",
              text: "You want to leave the game?",
              icon: "warning",
              buttons: true,
              dangerMode: true,
            })
        .then((willDelete) => {
          if (willDelete) {
            swal("You are no longer playing the game!", {
              icon: "success",
            });
            if ((this.state.p1 == window.playerName) || (this.state.p2 == window.playerName)){
              console.log("You pressed OK!");
               this.channel
             .push("leave", {player: window.playerName})
             .receive("ok", this.gotView.bind(this));
           }
          } else {

          }
    });

  }

  reset(){
        swal({
              title: "Are you sure?",
              text: "You want to reset the game?",
              icon: "warning",
              buttons: true,
              dangerMode: true,
            })
            .then((willDelete) => {
              if (willDelete) {
                swal("The game has been reset!", {
                  icon: "success",
                });
                console.log("You pressed OK!");
                 this.channel
               .push("reset")
               .receive("ok", this.gotView.bind(this));
              } else {
                // swal("Your imaginary file is safe!");
              }
            });


    // if (confirm("Are you sure, you want to reset the game?")){
    //     console.log("You pressed OK!");
    //      this.channel
    //    .push("reset")
    //    .receive("ok", this.gotView.bind(this));
    // }
  }

  serverClickHandle(card, i, j) {
    console.log("here");
    if (this.state.p1_turn && (this.state.p1 == window.playerName)) {
      this.channel
        .push("handleclickfn", { i: i, j: j})
        .receive("ok", this.gotView.bind(this));

    }
    else if (!(this.state.p1_turn) &&  (this.state.p2 == window.playerName) ) {
      this.channel
        .push("handleclickfn", { i: i, j: j})
        .receive("ok", this.gotView.bind(this));


    }
    else{
      // alert("Trying to be oversmart huh!?")
      swal("Trying to be oversmart huh!?");
    }

    // this.state.winner==1? swal({
    //                             title: "THE WINNER IS..",
    //                             text: this.state.p1,
    //                             icon: "success",
    //                             button: "Yayy"
    //                           })
    //                           :this.state.winner==2?
    //                           swal({
    //                                 title: "THE WINNER IS..",
    //                                 text: this.state.p2,
    //                                 icon: "success",
    //                                 button: "Yayy"
    //                               })
    //                               :"";

  }

  render() {

    let playerturn  = <div>
    <b>{
      //main condition if
      (this.state.p1 == null || this.state.p2 == null) ?
      //reply for main
           "Waiting for Players to Join Game":
      //else
           (
           // if 2 
           ( (this.state.p1 == window.playerName) || (this.state.p2 == window.playerName))?
              (
                //if 3
                this.state.p1_turn ? 
                    //if 4
                      (this.state.p1 == window.playerName ?
                        "Your Turn" :
                     //else 4
                        "Opponent's Turn" ) :
                // else 3
                (this.state.p2 == window.playerName)?
                  "Your Turn" :
                  "Opponent's Turn"
                )

          //else 2
            : (this.state.p1_turn)?
              (this.state.p1 + "'s turn")
              : (this.state.p2 + "'s turn")
            )}</b></div>
    

    let cardsRendered = Object.keys(this.state.grid).map((cardrow, rowindex) => (
      <table key={rowindex}>
      <tbody>
      <tr key={rowindex}>
      {Object.keys (this.state.grid[cardrow]).map((card, i) => (
        <td
        key={i}
        onClick={() => this.serverClickHandle(card, rowindex, i)}>

        <div
        className={
          this.state.grid[cardrow][card] == 0 ? "card" :
          this.state.grid[cardrow][card] == 1 ? "blackTile" :
          this.state.grid[cardrow][card] == 2 ? "whiteTile" : 
          this.state.p1_turn ? "flipWhite":"flipBlack"
        }>
        </div>
        </td>
        ))}
      </tr>
      </tbody>
      </table>
      ));



    let messageList = <div className="messagecontent"><ChatFeed
            //chatBubble={this.state.useCustomBubble && customBubble}
            maxHeight={563}
            messages={this.state.msg.reverse().map((data, index) =>( (data.senderName === window.playerName)?
              (new Message ({id: 0 ,message: data.message ,senderName: data.senderName})):
              (new Message(data))))} // Boolean: list of message objects
            showSenderName
            /></div>

    let gamep1button = (<div>
     {(this.state.p1 === null && !(this.state.p2 === window.playerName) ) ? ( <button type="submit" data-toggle="modal" data-target="#player1Join"
      className="btn btn-primary my-2"
      onClick={() => this.p1join()}>
      Join Game as Player1</button>)
     :(this.state.p2 === window.playerName && (this.state.p1 === null))?"Waiting for Player1 to join game":""}
     </div>);

    let gamep1leavebutton =(<div className="mt-2"> {this.state.p1 == window.playerName ?
      (<span>
       <button type="submit" onClick={() => this.leaveCurrentGame()} className="btn btn-primary mr-3">Leave</button>
       <button type="submit" onClick={() => this.reset()} className="btn btn-secondary">Reset</button>
       </span>):("")} </div>);

    let gamep2button = (<div>
     {(this.state.p2 === null && !(this.state.p1 == window.playerName)) ? ( <button type="submit" className="btn btn-primary my-2"
      onClick={() => this.p2join()}>
      Join Game as Player2</button>)
     :(this.state.p1 === window.playerName && (this.state.p2 === null))?"Waiting for Player2 to join game":""}
     </div>);

    let gamep2leavebutton =(<div className="mt-2"> {this.state.p2 == window.playerName ?
      (<span>
       <button type="submit" onClick={() => this.leaveCurrentGame()} className="btn btn-primary mr-3">Leave</button>
       <button type="submit" onClick={() => this.reset()} className="btn btn-secondary">Reset</button>
       </span>):("")} </div>);

    return <div className = "jsxGameContainer">
            <div className ="container">
              <div className="row">

              </div>
              <div className="row">
                <div className="d-flex flex-column mx-auto my-auto float-left">
                  <div className="row">
                    <div className="text-center text-white player1">
                      <h4> Player1  </h4>
                      <img src="http://othellogame.net/revello/images/chip-white-1x.png" height="55" width="55"/>
                      <p> Name: {this.state.p1} </p>
                      <p> <h2> {this.state.p1score} </h2> Score</p>
                      <p> {gamep1button} {gamep1leavebutton}</p>
                    </div>
                  </div>
                  <div className="row">
                    <div className="player2 text-white text-center">
                      <h4> Player2   </h4>
                      <img src="http://othellogame.net/revello/images/chip-black-1x.png" height="55" width="55"/>
                      <p> Name: {this.state.p2} </p>
                      <p> <h2> {this.state.p2score} </h2> Score</p>
                      <p> {gamep2button} {gamep2leavebutton}</p>
                    </div>
                  </div>
                </div>
                <div className="d-flex flex-column mx-auto">
                  <table className="table" id="gametable">
                    <tbody>
                      <tr>
                        <td> {  cardsRendered   } </td>
                      </tr>
                    </tbody>
                  </table>
                  <div className="text-center">
                    <p className="mt-2 text-white h4"> {playerturn}  </p>
                  </div>
                  <div className="text-center text-white h4">
                    <button type="submit" onClick={() => this.leave()} className="btn btn-primary mt-3">Leave the Game</button>
                  </div>
                </div>
                <div className="d-flex flex-column mx-auto float-right">
                  <div className="row">   
                    <div className="chatcontainer">
                      <div className="chatfeed-wrapper">
                        {messageList}
                      </div>
                      <div className="chatInputBox">
                        <input placeholder={"Press Enter to Send"} onKeyDown={this.keyPress} onChange={this.handleChange} />
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        }
      }
