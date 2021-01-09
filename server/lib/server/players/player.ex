defmodule Server.Players.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "players" do
    field(:attempts, :integer)
    field(:attempts_avg, :float)
    field(:avg_yards_per_attempts, :float)
    field(:first_down, :integer)
    field(:first_down_ratio, :float)
    field(:fourty_yards, :integer)
    field(:fumbles, :integer)
    field(:longest_rush, :string)
    field(:name, :string)
    field(:position, :string)
    field(:team, :string)
    field(:total_touchdowns, :integer)
    field(:total_yards, :float)
    field(:twenty_yards, :integer)
    field(:yards_per_game, :float)

    timestamps()
  end

  @optional_fields []
  @required_fields [
    :attempts_avg,
    :attempts,
    :avg_yards_per_attempts,
    :first_down_ratio,
    :first_down,
    :fourty_yards,
    :fumbles,
    :longest_rush,
    :name,
    :position,
    :team,
    :total_touchdowns,
    :total_yards,
    :twenty_yards,
    :yards_per_game
  ]

  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, @optional_fields ++ @required_fields)
    |> validate_required(@required_fields)
  end
end
