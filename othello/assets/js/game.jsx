import React from "react";
import ReactDOM from "react-dom";
import { Button } from "reactstrap";
import { Progress } from "reactstrap";
import { Table } from "reactstrap";
//chatfeed api attribution: https://github.com/brandonmowat/react-chat-ui/tree/message-groups/src/ChatBubble
import { ChatFeed, Message } from 'react-chat-ui';
//declare var pName;

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
    this.setState(game)});  
    
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
      msg: []
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
     if (confirm("Are you sure, you want to join as Player1")) {
        console.log("You pressed OK!");
        this.channel
      .push("player1join", {player1: window.playerName})
      .receive("ok", this.gotView.bind(this));
    } else {
        //close popup
    }
  }

  p2join(){
     if (confirm("Are you sure, you want to join as Player2")) {
        console.log("You pressed OK!");
        this.channel
      .push("player2join", {player2: window.playerName})
      .receive("ok", this.gotView.bind(this));
    } else {
        //close popup
    }
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
      alert("Trying to be oversmart huh!?")
    }
  }

  render() {

    let playerturn  = <div><b>{(this.state.p1 == null || this.state.p2 == null) ? "":
    this.state.p1_turn? "Player1: " + this.state.p1 + "'s Turn": "Player2: " + this.state.p2 + "'s Turn"}</b></div>

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
                          this.state.grid[cardrow][card] == 1 ? "cardReveal" : 
                          this.state.grid[cardrow][card] == 2 ? "cardFlip" : "cardFlip1"
                  }>
                </div>
              </td>
            ))}
          </tr>
        </tbody>
      </table>
    ));

    // let moosg = ( <div> {this.state.msg.map((card, i) => (console.log(card ,i)))} </div>);
    let messageList = <ChatFeed
            //chatBubble={this.state.useCustomBubble && customBubble}
            maxHeight={250}
            messages={this.state.msg.reverse().map((data, index) =>( (data.senderName === window.playerName)?
              (new Message ({id: 0 ,message: data.message ,senderName: data.senderName})):
              (new Message(data))))} // Boolean: list of message objects
            showSenderName
            //  bubbleStyles={
            //   {
            //     text: {
            //       fontSize: 30, 
            //       color: "white"
            //     },
            //     chatbubble: {
            //       borderRadius: 70,
            //       padding: 40
            //     }
            //   }
            // }
          />

    let gamep1button = (<div>
                   {(this.state.p1 === null && !(this.state.p2 === window.playerName) ) ? ( <button type="submit" data-toggle="modal" data-target="#player1Join"
                    className="btn btn-primary my-2"
                    onClick={() => this.p1join()}>
                    Join Game as Player1</button>)
                   :(this.state.p2 === window.playerName && (this.state.p1 === null))?"Waiting for Player1 to join game":""}
                  </div>);
    let gamep1leavebutton =(<div className="mt-2"> {this.state.p1 == window.playerName ?
                    (<span>
                       <button type="submit" className="btn btn-primary mr-3">Leave</button>
                       <button type="submit" className="btn btn-secondary">Reset</button>
                    </span>):("")} </div>);

    let gamep2button = (<div>
                   {(this.state.p2 === null && !(this.state.p1 == window.playerName)) ? ( <button type="submit" className="btn btn-primary my-2"
                    onClick={() => this.p2join()}>
                    Join Game as Player2</button>)
                   :(this.state.p1 === window.playerName && (this.state.p2 === null))?"Waiting for Player2 to join game":""}
                  </div>);
    let gamep2leavebutton =(<div className="mt-2"> {this.state.p2 == window.playerName ?
                    (<span>
                       <button type="submit" className="btn btn-primary mr-3">Leave</button>
                       <button type="submit" className="btn btn-secondary">Reset</button>
                    </span>):("")} </div>);

    return <div className ="container">
    <div className="row">
      <div className="d-flex flex-column mx-auto my-auto float-left">
        <div className="border border-white text-center text-white player1">
          <h4> Player1  </h4>
          <img src="http://othellogame.net/revello/images/chip-white-1x.png" height="55" width="55"/>
          <p> Name: {this.state.p1} </p>
          <p> <h2> {this.state.p1score} </h2> Score</p>
           <p> {gamep1button} {gamep1leavebutton}</p>
           <p className="mt-2"> {playerturn}  </p>
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
           <div className="text-center text-white">
           </div>       
        <div className="text-center">
          <button type="submit" className="btn btn-primary mt-3">Leave the Game</button>
        </div>
      </div>
      <div className="d-flex flex-column mx-auto my-auto float-right">
        <div className="border border-light player2 text-white text-center">
          <h4> Player2   </h4>
          <img src="http://othellogame.net/revello/images/chip-black-1x.png" height="55" width="55"/>
          <p> Name: {this.state.p2} </p>
          <p> <h2> {this.state.p2score} </h2> Score</p>
          <p> {gamep2button} {gamep2leavebutton}</p>
          <p className="mt-2"> {playerturn}  </p>
         </div>
      </div>
    </div>
    <div className="chatcontainer">
        <div className="chatfeed-wrapper">
        {messageList}
          <input placeholder={window.playerName + "Enter your msg"} onKeyDown={this.keyPress} onChange={this.handleChange} />
   </div> 
    </div>
    </div>
  }
}
