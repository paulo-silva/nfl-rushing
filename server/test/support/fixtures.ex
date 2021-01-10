defmodule Server.Fixtures do
  @moduledoc """
  A module for defining fixtures that can be used in tests.
  This module can be used with a list of fixtures to apply as parameter:
      use Server.Fixtures, [:player]
  """

  def player do
    alias Server.Players

    quote do
      @valid_attrs %{
        attempts: 2,
        attempts_avg: 2.0,
        avg_yards_per_attempts: 3.5,
        first_down: 0,
        first_down_ratio: 0.0,
        fourty_yards: 0,
        fumbles: 0,
        id: 1,
        inserted_at: ~N[2021-01-10 00:51:46],
        longest_rush: "7",
        name: "Joe Banyard",
        position: "RB",
        team: "JAX",
        total_touchdowns: 0,
        total_yards: 7.0,
        twenty_yards: 0,
        updated_at: ~N[2021-01-10 00:51:46],
        yards_per_game: 7.0
      }

      def player_fixture(attrs \\ %{}) do
        {:ok, player} =
          attrs
          |> Enum.into(@valid_attrs)
          |> Players.create_player

        player
      end
    end
  end

  @doc """
  Apply the `fixtures`.
  """
  defmacro __using__(fixtures) when is_list(fixtures) do
    for fixture <- fixtures, is_atom(fixture),
      do: apply(__MODULE__, fixture, [])
  end
end
