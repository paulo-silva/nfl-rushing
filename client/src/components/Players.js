import { Component } from "react";
import { filterPlayersByName, loadPlayers } from "../api";
import Table from "./Table";
import './Players.css';

class Players extends Component {
  constructor(props) {
    super(props);

    this.state = {
      offset: 0,
      limit: 30,
      sort_by: "",
      name: "",
      sort_dir: "asc",
      players: []
    };
  }

  componentDidMount() {
    loadPlayers(this.state, players => this.setState({ players }))
  }

  playersHeader() {
    return [
      "Player",
      "Team",
      "Pos",
      "Att/G",
      "Att",
      "Yrds",
      "Avg",
      "Yds/G",
      "TD",
      "Lng",
      "1st",
      "1st%",
      "20+",
      "40+",
      "FUM"
    ];
  }

  sortableColumns() {
    return ["Lng", "TD", "Yrds"]
  }

  buildPlayersRows(players) {
    return players.map(player => [
      player.name,
      player.team,
      player.position,
      player.attempts_avg,
      player.attempts,
      player.total_yards,
      player.avg_yards_per_attempts,
      player.yards_per_game,
      player.total_touchdowns,
      player.longest_rush,
      player.first_down,
      player.first_down_ratio,
      player.twenty_yards,
      player.fourty_yards,
      player.fumbles
    ])
  }

  handleHeaderClick(event) {
    const clickedColumn = event.target.getAttribute('name');

    this.sortPlayersBy(clickedColumn)
  }

  sortPlayersBy(column) {
    const columnToField = {
      Lng: "longest_rush",
      TD: "total_touchdowns",
      Yrds: "total_yards"
    }
    const currentSortDir = this.state.sort_dir
    const newSortDir = currentSortDir == 'asc' ? 'desc' : 'asc'

    if (columnToField[column]) {
      this.setState({
        sort_by: columnToField[column],
        sort_dir: this.state.sort_by == columnToField[column] ? newSortDir : 'asc'
      })

      loadPlayers(this.state, players => this.setState({ players }))
    }
  }

  handleNameFilterChange(event) {
    const name = event.target.value

    filterPlayersByName(name, players => this.setState({ players }))
  }

  render() {
    return (
      <div class="Players">
        <input
          className="PlayersFilter"
          onChange={this.handleNameFilterChange.bind(this)}
          placeholder="Filter by Player Name"
        />
        <Table
          onHeaderClick={this.handleHeaderClick.bind(this)}
          sortableColumns={this.sortableColumns()}
          header={this.playersHeader()}
          rows={this.buildPlayersRows(this.state.players)}
        />
      </div>
    )
  }
}

export default Players
