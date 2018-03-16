import React from "react";
import ReactDOM from "react-dom";
import { Button } from "reactstrap";
import { Progress } from "reactstrap";
import { Table } from "reactstrap";

export default function run_game(root, channel) {
  ReactDOM.render(<Game channel={channel} />, root);
}

class Layout extends React.Component {

  constructor(props) {
    super(props);
    }

  
  render() {
    return (
      <div>
        Game Page Yet to be coded
      </div>
    );
  }

}