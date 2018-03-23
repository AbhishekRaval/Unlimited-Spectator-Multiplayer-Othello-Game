import React from "react";
import ReactDOM from "react-dom";
import { Button } from "reactstrap";
import { Progress } from "reactstrap";
import { Table } from "reactstrap";
//declare var pName;

export default function run_game(root, channel) { ReactDOM.render( <Layout width = {  8  }
  height = {  8  }
  str = {"AABBCCDDEEFFGGHHAABBCCDDEEFFGGHHAABBCCDDEEFFGGHHAABBCCDDEEFFGGHH"} channel = {channel} />, root)}

const gameStatesType = {
  WFC: "WAITING_FIRST_CARD",
  WSC: "WAITING_SECOND_CARD",
  WRONG: "WRONG",
  TIMEOUT: "TIMEOUT"
};

class Card extends React.Component {
  render() {
    return <div className ={ !this.props.card.flipped?"card":((this.props.card.colState===1)?"cardReveal":"cardFlip")} >
      <span><div className = "middlefont"> {
        this.props.card.flipped ? this.props.card.cardValue:" "}</div></span> </div >
  }
}


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

    this.channel.on("player2join",payload=>
    {let game = payload.game;
    this.setState(game)});

    this.state = {
      p1_turn: true,
      grid: [],
      p1: null,
      p2:null,
      p1score: 0,
      p2score: 0
    };
  }

  gotView(msg) {
    console.log("Got View", msg);
    this.setState(msg.game);
  }

s

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
     if (confirm("Are you sure, you want to join as Player1")) {
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

    // if (this.state.p1_turn) {
    //   this.channel
    //   .push("handleclickfn", { i: i, j: j, pn: this.state.p1 })
    //   .receive("ok", this.gotView.bind(this));
    // }
    // else {
    //   this.channel
    //   .push("handleclickfn", { i: i, j: j, pn: this.state.p2 })
    //   .receive("ok", this.gotView.bind(this));
    // }
    // if (this.state.percent == 100) {
    //   alert("Game Complete, Click Reset Game to start new Game.")
    // }
  }

  render() {

    let playerturn  = <div><b>{(this.state.p1 == null || this.state.p2 == null) ? "":
    this.state.p1_turn? this.state.p1 + "'s Turn": this.state.p2 + "'s Turn"}</b></div>
    let cardsRendered = Object.keys(this.state.grid).map((cardrow, rowindex) => (
      <table key={rowindex}>
        <tbody>
          <tr key={rowindex}>
            {Object.keys(this.state.grid[cardrow]).map((card, i) => (
              <td
                key={i}
                onClick={() => this.serverClickHandle(card, rowindex, i)}

                >

                <div
                  className={
                    this.state.grid[cardrow][card] == 0 ? "card" :
                          this.state.grid[cardrow][card] == 1 ? "cardReveal" : "cardFlip"
                  }>
                </div>
              </td>
            ))}
          </tr>
        </tbody>
      </table>
    ));

    let gamep1button = (<div>
                   {this.state.p1 === null  ? ( <button type="submit" data-toggle="modal" data-target="#player1Join"
                    className="btn btn-primary my-2"
                    onClick={() => this.p1join()}>
                    Join Game as Player1</button>)
                   : ("Player1 playing")}
                  </div>);
    let gamep1leavebutton =(<div> {this.state.p1 == window.playerName ?
                    (<span>
                       <button type="submit" className="btn btn-primary mr-3">Leave</button>
                       <button type="submit" className="btn btn-secondary">Reset</button>
                    </span>):("")} </div>);

    let gamep2button = (<div>
                   {this.state.p2 === null  ? ( <button type="submit" className="btn btn-primary my-2"
                    onClick={() => this.p2join()}>
                    Join Game as Player2</button>)
                   : ("Player2 playing")}
                  </div>);
    let gamep2leavebutton =(<div> {this.state.p2 == window.playerName ?
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
    </div>
  }
}
