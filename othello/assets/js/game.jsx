import React from "react";
import ReactDOM from "react-dom";
import { Button } from "reactstrap";
import { Progress } from "reactstrap";
import { Table } from "reactstrap";

export default function run_game(root, channel) {
  ReactDOM.render( < Layout width = {
    8
  }
  height = {
    8
  }
  str = {
    "AABBCCDDEEFFGGHHAABBCCDDEEFFGGHHAABBCCDDEEFFGGHHAABBCCDDEEFFGGHH"
  }
  />, root);
}

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
    if (props.width * props.height % 2 == 1) {
      alert("Number of Cards is Odd");
    }
    if (props.width * props.height != props.str.length) {
      alert("String should be of the size" + props.width * props.height)
    }
    var cards = createArray(props.height, props.width);
    var possArray = generateStringArray(props.str);
    for (var i = 0; i < props.height; i++) {
      for (var j = 0; j < props.width; j++) {
        cards[i][j] = {
          cardValue: possArray[i * props.width + j],
          flipped: false,
          i: i,
          j: j,
          colState:0
        };
      }
    }

    this.state = {
      cards: cards,
      gameState: gameStatesType.WFC,
      firstCard: null,
      secondCard: 0,
      count: 0,
      score: 0,
      percent:0,
      height:props.height,
      width:props.width,
      str:props.str
    };
  }
  render() {
    const cardsRendered = this.state.cards.map((rowOfCards, rowindex) => < tr > {
          rowOfCards.map((card, cardIndex) => < td onClick = {
              () => this.cardClick(card)
            } > < Card card = {
              card
            }
            /></td > )
        } < /tr>);
       
       
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
