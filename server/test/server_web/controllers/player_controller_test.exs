defmodule PlayerControllerTest do
  use ServerWeb.ConnCase
  use Server.Fixtures, [:player]

  describe "index/2" do
    test "list all players", %{conn: conn} do
      player_names = ["John", "Robby", "Todd"]
      Enum.each(player_names, &player_fixture(%{name: &1}))

      resp =
        conn
        |> get(Routes.player_path(conn, :index))
        |> json_response(200)

      assert length(resp) == 3
      names_in_json = Enum.map(resp, & &1["name"])

      assert Enum.all?(player_names, &Enum.member?(names_in_json, &1))
    end

    test "list all players in csv format", %{conn: conn} do
      player_names = ["John", "Robby", "Todd"]
      Enum.each(player_names, &player_fixture(%{name: &1}))

      csv_response =
        conn
        |> put_req_header("accept", "text/csv")
        |> get(Routes.player_path(conn, :index))

      assert response_content_type(csv_response, :csv)
    end

    test "able to sort by player info", %{conn: conn} do
      Enum.each(1..3, fn i -> player_fixture(%{total_touchdowns: i}) end)

      resp =
        conn
        |> get(Routes.player_path(conn, :index, sort_by: "total_touchdowns", sort_dir: "desc"))
        |> json_response(200)

      assert Enum.map(resp, & &1["total_touchdowns"]) == [3, 2, 1]
    end

    test "allow to filter by player name", %{conn: conn} do
      expected_result_names = ["Paulo Henrique", "Marcos Paulo"]
      player_names = expected_result_names ++ ["João", "José"]
      Enum.each(player_names, &player_fixture(%{name: &1}))

      resp =
        conn
        |> get(Routes.player_path(conn, :index, name: "paulo"))
        |> json_response(200)

      names_in_resp = Enum.map(resp, & &1["name"])

      assert Enum.all?(expected_result_names, &Enum.member?(names_in_resp, &1))
    end

    test "allow to paginate the result", %{conn: conn} do
      player_names = ["John", "Robby", "Todd"]
      Enum.each(player_names, &player_fixture(%{name: &1}))

      resp =
        conn
        |> get(Routes.player_path(conn, :index, limit: 1, offset: 0))
        |> json_response(200)

      assert length(resp) == 1
      assert [%{"name" => "John"}] = resp

      resp =
        conn
        |> get(Routes.player_path(conn, :index, limit: 1, offset: 2))
        |> json_response(200)

      assert length(resp) == 1
      assert [%{"name" => "Todd"}] = resp
    end

    test "allow to group by team", %{conn: conn} do
      player_names = ["John", "Robby", "Todd"]
      Enum.each(player_names, &player_fixture(%{name: &1, team: "SEA"}))

      player_names_2 = ["Joao", "Paulo"]
      Enum.each(player_names_2, &player_fixture(%{name: &1, team: "NYG"}))

      resp =
        conn
        |> get(Routes.player_path(conn, :index, group_by: "team"))
        |> json_response(200)

      assert length(resp) == 2

      assert Enum.member?(resp, %{"team" => "SEA", "players" => "John, Robby, Todd", "total_yards" => 21.0})
      assert Enum.member?(resp, %{"team" => "NYG", "players" => "Joao, Paulo", "total_yards" => 14.0})
    end

    test "allow to sort by total yards sum based on team", %{conn: conn} do

    end
  end
end
