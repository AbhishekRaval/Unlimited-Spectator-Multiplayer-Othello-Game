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

      console.log(window.playerName);

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
    // if ((this.state.width * this.state.height) % 2 == 1) {
    //   alert("Number of Cards is Odd");
    // }
    // if (this.state.width * this.state.height != this.state.str.length) {
    //   alert(
    //     "String should be of the size" + this.state.width * this.state.height
    //   );
    // }
  }

  serverClickHandle(card, i, j) {
    console.log("here");
    this.channel
      .push("handleclickfn", { i: i, j: j})
      .receive("ok", this.gotView.bind(this));
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

    let playerturn  = <div><b>{this.state.p1_turn? this.state.player1 + "'s Turn": this.state.player2 + "'s Turn"}</b></div>
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
                    this.state.grid[cardrow][card] == 0 ? "card" : this.state.grid[cardrow][card] == 1 ? "cardReveal" : "cardFlip"
                  }>
                  <div className="middlefont">
                    {card.flipped ? card.cardValue : " "}
                  </div>
                </div>
              </td>
            ))}
          </tr>
        </tbody>
      </table>
    ));


    return <div className ="container">
    <div className="row">
      <div className="d-flex flex-column mx-auto my-auto float-left">
        <div className="border border-primary text-center player1">
          <h4> Player1 Details:  </h4>
          <p> Player1: {this.state.pl} </p>
          <p> Player1's Score : {this.state.p1score}  </p>
          <span>
             <button type="submit" className="btn btn-primary mr-3">Leave</button>
             <button type="submit" className="btn btn-secondary">Reset</button>
          </span>
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
        <span className="border border-primary player2 text-center">
          <h4> Player2 Details:  </h4>
          <p> Player2: {this.state.p2} </p>
          <p> Player2's Score : {this.state.p2score}  </p>
          <span>
             <button type="submit" className="btn btn-primary mr-3">Leave</button>
             <button type="submit" className="btn btn-secondary">Reset</button>
          </span>
          <p className="mt-2"> {playerturn}  </p>
         </span>
      </div>
    </div>      
    </div>
  }
}
