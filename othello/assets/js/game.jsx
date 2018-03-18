import React from "react";
import ReactDOM from "react-dom";
import { Button } from "reactstrap";
import { Progress } from "reactstrap";
import { Table } from "reactstrap";

export default function run_game(root, channel) { ReactDOM.render( < Layout width = {  8  }
  height = {  8  }
  str = {    "AABBCCDDEEFFGGHHAABBCCDDEEFFGGHHAABBCCDDEEFFGGHHAABBCCDDEEFFGGHH"}  />, root); }

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


function generateStringArray(str) {
  var arr = new Array(16);
  for (var i = 0; i < str.length; i++) {
    arr[i] = str.charAt(i);
  }
  arr = shuffle(arr);
  return arr;
}

function shuffle(array) {
  let counter = array.length;

  // While there are elements in the array
  while (counter > 0) {
    // Pick a random index
    let index = Math.floor(Math.random() * counter);

    // Decrease counter by 1
    counter--;

    // And swap the last element with it
    let temp = array[counter];
    array[counter] = array[index];
    array[index] = temp;
  }
  return array;
}

function createArray(length) {
  var arr = new Array(length || 0),
    i = length;

  if (arguments.length > 1) {
    var args = Array.prototype.slice.call(arguments, 1);
    while (i--) arr[length - 1 - i] = createArray.apply(this, args);
  }

  return arr;
}

class Layout extends React.Component {
  constructor(props) {
    super(props);
    this.channel = props.channel;
    this.channel
      .join()
      .receive("ok", this.gotView.bind(this))
      .receive("error", resp => {
      console.log("Unable to join, failed", resp);
    });

    this.state = {
      p1_turn: true,
      grid: null,
      p1: null,
      p2:null,
      p1score: 0,
      p2score: 0
    };
  }

  gotView(msg) {
    console.log("Got View", msg);
    this.setState(msg.game);
    if ((this.state.width * this.state.height) % 2 == 1) {
      alert("Number of Cards is Odd");
    }
    if (this.state.width * this.state.height != this.state.str.length) {
      alert(
        "String should be of the size" + this.state.width * this.state.height
      );
    }
  }

  serverClickHandle(card, i, j) {
    console.log("here");
    this.channel
      .push("handleclickfn", { i: i, j: j })
      .receive("ok", this.gotView.bind(this));
       if (this.state.percent == 100) {
      alert("Game Complete, Click Reset Game to start new Game.")
    }
  }

  render() {
    let cardsRendered = this.state.grid.map((cardrow, rowindex) => (
      <table key={rowindex}>
        <tbody>
          <tr key={rowindex}>
            {cardrow.map((card, i) => (
              <td
                key={i}
                onClick={() => this.serverClickHandle(card, rowindex, i)}
                >
                <div
                  className={
                    !card.flipped
                      ? "card"
                    : card.colstate == 1 ? "cardReveal" : "cardFlip"
                  }
                  >
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
       
       
       return <div> 
       <div class="row">
    <table class="table table-dark">
    <tbody>
    <tr>
    <td> {  cardsRendered   } </td> 
    < /tr > < /tbody>
     < /table > </div>
     <div class="text-center"> 
       <button type="submit" class="btn btn-primary">Leave the Game</button>    
    </div>        
       < /div> 







  }
}
