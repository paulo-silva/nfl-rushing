defmodule Server.PlayersTest do
  use Server.DataCase

  alias Server.Players

  describe "players" do
    alias Server.Players.Player

    @valid_attrs %{
      attempts: 42,
      attempts_avg: 120.5,
      avg_yards_per_attempts: 120.5,
      first_down: 42,
      first_down_ratio: 120.5,
      fourty_yards: 42,
      fumbles: 42,
      longest_rush: 42,
      longest_rush_with_touchdown: true,
      name: "some name",
      position: "some position",
      team: "some team",
      total_touchdowns: 42,
      total_yards: 120.5,
      twenty_yards: 42,
      yards_per_game: 120.5
    }
    @update_attrs %{
      attempts: 43,
      attempts_avg: 456.7,
      avg_yards_per_attempts: 456.7,
      first_down: 43,
      first_down_ratio: 456.7,
      fourty_yards: 43,
      fumbles: 43,
      longest_rush: 42,
      longest_rush_with_touchdown: false,
      name: "some updated name",
      position: "some updated position",
      team: "some updated team",
      total_touchdowns: 43,
      total_yards: 456.7,
      twenty_yards: 43,
      yards_per_game: 456.7
    }
    @invalid_attrs %{
      attempts: nil,
      attempts_avg: nil,
      avg_yards_per_attempts: nil,
      first_down: nil,
      first_down_ratio: nil,
      fourty_yards: nil,
      fumbles: nil,
      longest_rush: nil,
      name: nil,
      position: nil,
      team: nil,
      total_touchdowns: nil,
      total_yards: nil,
      twenty_yards: nil,
      yards_per_game: nil
    }

    def player_fixture(attrs \\ %{}) do
      {:ok, player} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Players.create_player()

      player
    end

    test "list_players/0 returns all players" do
      player = player_fixture()
      assert Players.list_players() == [player]
    end

    test "get_player_by_name/1 returns a single player" do
      assert {:ok, %Player{name: player_name}} = Players.create_player(@valid_attrs)

      assert %Player{} = Players.get_player_by_name(player_name)
      refute Players.get_player_by_name("Invalid Player")
    end

    test "create_player/1 with valid data creates a player" do
      assert {:ok, %Player{} = player} = Players.create_player(@valid_attrs)
      assert player.attempts == 42
      assert player.attempts_avg == 120.5
      assert player.avg_yards_per_attempts == 120.5
      assert player.first_down == 42
      assert player.first_down_ratio == 120.5
      assert player.fourty_yards == 42
      assert player.fumbles == 42
      assert player.longest_rush == 42
      assert player.name == "some name"
      assert player.position == "some position"
      assert player.team == "some team"
      assert player.total_touchdowns == 42
      assert player.total_yards == 120.5
      assert player.twenty_yards == 42
      assert player.yards_per_game == 120.5
    end

    test "create_player/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Players.create_player(@invalid_attrs)
    end

    test "update_player/2 with valid data updates the player" do
      player = player_fixture()
      assert {:ok, %Player{} = player} = Players.update_player(player, @update_attrs)
      assert player.attempts == 43
      assert player.attempts_avg == 456.7
      assert player.avg_yards_per_attempts == 456.7
      assert player.first_down == 43
      assert player.first_down_ratio == 456.7
      assert player.fourty_yards == 43
      assert player.fumbles == 43
      assert player.longest_rush == 42
      assert player.name == "some updated name"
      assert player.position == "some updated position"
      assert player.team == "some updated team"
      assert player.total_touchdowns == 43
      assert player.total_yards == 456.7
      assert player.twenty_yards == 43
      assert player.yards_per_game == 456.7
    end

    test "update_player/2 with invalid data returns error changeset" do
      player = player_fixture()
      assert {:error, %Ecto.Changeset{}} = Players.update_player(player, @invalid_attrs)
      assert player == Players.get_player!(player.id)
    end

    test "delete_player/1 deletes the player" do
      player = player_fixture()
      assert {:ok, %Player{}} = Players.delete_player(player)
      assert_raise Ecto.NoResultsError, fn -> Players.get_player!(player.id) end
    end

    test "change_player/1 returns a player changeset" do
      player = player_fixture()
      assert %Ecto.Changeset{} = Players.change_player(player)
    end
  end
end
