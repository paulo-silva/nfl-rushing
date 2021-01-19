defmodule ServerWeb.PlayerController do
  use ServerWeb, :controller
  alias Server.Players
  alias Server.Players.Player

  def index(conn, params) do
    sort_dir = String.to_existing_atom(params["sort_dir"] || "asc")

    players =
      Player
      |> Players.sort_players_by(params["sort_by"], sort_dir)
      |> maybe_paginate(conn, params)
      |> Players.filter_by_name(params["name"])
      |> Players.group_by(params["group_by"])
      |> Players.list_players()

    render(conn, :index, players: players)
  end

  # Does not paginate for csv response
  defp maybe_paginate(query, %{private: %{phoenix_format: "csv"}}, _params), do: query

  defp maybe_paginate(query, _conn, params) do
    limit = Map.get(params, "limit", 30)
    offset = Map.get(params, "offset", 0)

    Players.paginate_players(query, limit, offset)
  end
end
