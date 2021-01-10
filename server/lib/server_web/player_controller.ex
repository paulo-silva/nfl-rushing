defmodule ServerWeb.PlayerController do
  use ServerWeb, :controller
  alias Server.Players

  def index(conn, _params) do
    players = Players.list_players()

    render(conn, :index, players: players)
  end
end
