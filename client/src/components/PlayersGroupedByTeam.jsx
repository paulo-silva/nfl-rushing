import React from "react";
import { filterPlayersByName, loadPlayers, generatePlayersCSV } from "../api";
import Table from "./Table";
import './Players.css';

class PlayersGroupedByTeam extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      offset: 0,
      limit: 30,
      sort_by: "",
      group_by: "team",
      name: "",
      sort_dir: "asc",
      players: [],
      lastPage: false
    };
  }

  componentDidMount() {
    loadPlayers(this.state, players => this.setState({ players }))
  }

  playersHeader() {
    return [
      "Team",
      "Players",
      "Yrds (Sum)",
    ];
  }

  sortableColumns() {
    return ["Yrds (Sum)"]
  }

  buildPlayersRows(players) {
    return players.map(player => [
      player.team,
      player.players,
      player.total_yards
    ])
  }

  handleHeaderClick(event) {
    const clickedColumn = event.target.getAttribute('name');

    this.sortPlayersBy(clickedColumn)
  }

  sortPlayersBy(column) {
    const columnToField = {
      "Yrds (Sum)": "total_yards_sum"
    }
    const currentSortDir = this.state.sort_dir
    const newSortDir = currentSortDir === 'asc' ? 'desc' : 'asc'

    if (columnToField[column]) {
      this.setState({
        sort_by: columnToField[column],
        sort_dir: this.state.sort_by === columnToField[column] ? newSortDir : 'asc'
      }, () => loadPlayers(this.state, players => this.setState({ players })))
    }
  }

  previousPage() { this.handlePagination("previous") }
  nextPage() { this.handlePagination("next") }

  handlePagination(direction) {
    const { offset, limit } = this.state
    const newOffset = direction === "previous" ? offset - limit : offset + limit

    this.setState({ offset: newOffset }, () => {
      loadPlayers(this.state, players =>
        this.setState({ players: players, lastPage: players.length === 0 })
      )
    })
  }

  render() {
    return (
      <div className="Players">
        <div className="PlayersActions">
          <div className="PlayersPaginationControl">
            <button {...this.state.offset === 0 && { disabled: true }} onClick={this.previousPage.bind(this)} class="Button ButtonBlue">Previous Page</button>
            <button {...this.state.lastPage && { disabled: true }} onClick={this.nextPage.bind(this)} class="Button ButtonBlue">Next Page</button>
          </div>
        </div>
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

export default PlayersGroupedByTeam
