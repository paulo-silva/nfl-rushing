alias Server.{Players}

filename = "./priv/repo/samples/rushing.json"

rushing_samples =
  filename
  |> File.read!()
  |> Jason.decode!()

# Sample validation
attrs = [
  "Player",
  "Team",
  "Pos",
  "Att/G",
  "Att",
  "Yds",
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

case Enum.all?(rushing_samples, &(Map.keys(&1) -- attrs == [])) do
  true ->
    "noop"

  false ->
    raise ArgumentError, message: "#{filename} has some invalid data"
end

# Persisting Players

defmodule SeedHelpers do
  def convert_to_string(val) when is_binary(val), do: val
  def convert_to_string(val), do: to_string(val)

  def convert_to_int(val) when is_integer(val), do: val
  def convert_to_int(val), do: String.replace(val, [".", ","], "") |> String.to_integer()

  def convert_to_float(val) do
    case Float.parse(to_string(val)) do
      :error -> nil
      {float_val, _} -> float_val
    end
  end
end

Enum.each(rushing_samples, fn player_data ->
  # Extract touchdown info from Lng data, and save it in a separated column
  [longest_rush, longest_rush_with_touchdown] =
    case Integer.parse("#{player_data["Lng"]}") do
      {lng, ""} -> [lng, false]
      {lng, "T"} -> [lng, true]
    end

  Players.create_player(%{
    name: player_data["Player"],
    team: player_data["Team"],
    position: player_data["Pos"],
    attempts_avg: player_data["Att/G"] |> SeedHelpers.convert_to_float(),
    attempts: player_data["Att"] |> SeedHelpers.convert_to_int(),
    total_yards: player_data["Yds"] |> SeedHelpers.convert_to_int(),
    avg_yards_per_attempts: player_data["Avg"] |> SeedHelpers.convert_to_float(),
    yards_per_game: player_data["Yds/G"] |> SeedHelpers.convert_to_float(),
    total_touchdowns: player_data["TD"] |> SeedHelpers.convert_to_int(),
    longest_rush: longest_rush,
    longest_rush_with_touchdown: longest_rush_with_touchdown,
    first_down: player_data["1st"] |> SeedHelpers.convert_to_int(),
    first_down_ratio: player_data["1st%"] |> SeedHelpers.convert_to_float(),
    twenty_yards: player_data["20+"] |> SeedHelpers.convert_to_int(),
    fourty_yards: player_data["40+"] |> SeedHelpers.convert_to_int(),
    fumbles: player_data["FUM"] |> SeedHelpers.convert_to_int()
  })
end)
