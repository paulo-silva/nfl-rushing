defmodule ServerWeb.PlayerView do
  use ServerWeb, :view

  def render("index.json", %{players: players}), do: players
end
