defmodule Server.Players do
  @moduledoc """
  The Players context.
  """

  import Ecto.Query, warn: false
  alias Server.Repo

  alias Server.Players.Player

  @doc """
  Returns the list of players.

  ## Examples

      iex> list_players()
      [%Player{}, ...]

      iex> sort_players_by("total_touchdowns", :desc) |> list_players()
      [%Player{}, ...]

  """
  def list_players(query \\ Player) do
    Repo.all(query)
  end

  @doc """
  Build query to sort player by a sortable field.

  ## Examples

      iex> sort_players_by("total_touchdowns", :desc)
      #Ecto.Query<from p0 in Player, order_by: [desc: p0.total_touchdowns]>
  """

  @sortable_fields ["longest_rush", "total_touchdowns", "total_yards"]
  def sort_players_by(query, field, direction) when field in @sortable_fields do
    get_players_ordered_by(query, field, direction)
  end

  def sort_players_by(query, "total_yards_sum", direction) do
    from(p in query, order_by: {^direction, sum(p.total_yards)})
  end

  def sort_players_by(query, _field, _direction), do: query

  defp get_players_ordered_by(query, field, direction) do
    field = String.to_existing_atom(field)

    from(p in query, order_by: {^direction, ^field})
  end

  def group_by(query, ""), do: query

  def group_by(query, "team") do
    from(
      p in query,
      group_by: [:team],
      select: %{
        "team" => p.team,
        "players" => fragment("string_agg(?, ', ')", p.name),
        "total_yards" => sum(p.total_yards)
      }
    )
  end

  @doc """
  Build query to paginate player records using given limit and offset.

  ## Examples

      iex> paginate_players(Player, 10, 0)
      #Ecto.Query<from p0 in Server.Players.Player, limit: ^10, offset: ^0>
  """
  def paginate_players(query, limit, offset) do
    from p in query,
      limit: ^limit,
      offset: ^offset
  end

  def filter_by_name(query, name) when not is_nil(name) and byte_size(name) > 0 do
    searched_term = "%#{name}%"

    from p in query, where: ilike(p.name, ^searched_term)
  end

  def filter_by_name(query, _name), do: query

  @doc """
  Gets a single player.

  Raises `Ecto.NoResultsError` if the Player does not exist.

  ## Examples

      iex> get_player!(123)
      %Player{}

      iex> get_player!(456)
      ** (Ecto.NoResultsError)

  """
  def get_player!(id), do: Repo.get!(Player, id)

  @doc """
  Search for a single player using the given name.

  Raises `Ecto.NoResultsError` if the Player does not exist.

  ## Examples

      iex> get_player_by_name!("Joe Banyard")
      %Player{}

      iex> get_player_by_name!("John Doe")
      ** (Ecto.NoResultsError)
  """
  def get_player_by_name(name), do: Repo.get_by(Player, name: name)

  @doc """
  Creates a player.

  ## Examples

      iex> create_player(%{field: value})
      {:ok, %Player{}}

      iex> create_player(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_player(attrs \\ %{}) do
    %Player{}
    |> Player.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a player.

  ## Examples

      iex> update_player(player, %{field: new_value})
      {:ok, %Player{}}

      iex> update_player(player, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_player(%Player{} = player, attrs) do
    player
    |> Player.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a player.

  ## Examples

      iex> delete_player(player)
      {:ok, %Player{}}

      iex> delete_player(player)
      {:error, %Ecto.Changeset{}}

  """
  def delete_player(%Player{} = player) do
    Repo.delete(player)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking player changes.

  ## Examples

      iex> change_player(player)
      %Ecto.Changeset{data: %Player{}}

  """
  def change_player(%Player{} = player, attrs \\ %{}) do
    Player.changeset(player, attrs)
  end
end
