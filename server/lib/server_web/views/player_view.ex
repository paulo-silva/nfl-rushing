defmodule ServerWeb.PlayerView do
  use ServerWeb, :view

  def render("index.json", %{players: players}), do: players

  @csv_header [
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
  ]
  def render("index.csv", %{players: players}) do
    csv_header = Enum.join(@csv_header, ",")
    player_rows = Enum.map(players, &create_csv_row/1)

    Enum.join([csv_header | player_rows], "\n")
  end

  defp create_csv_row(player) do
    [
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
    ]
    |> Enum.join(",")
  end
end
