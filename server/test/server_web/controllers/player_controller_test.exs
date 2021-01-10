defmodule PlayerControllerTest do
  use ServerWeb.ConnCase

  describe "index/2" do
    use Server.Fixtures, [:player]

    test "list all players", %{conn: conn} do
      player_names = ["John", "Robby", "Todd"]
      Enum.each(player_names, &(player_fixture(%{name: &1})))

      resp =
        conn
        |> get(Routes.player_path(conn, :index))
        |> json_response(200)

      assert length(resp) == 3
      names_in_json = Enum.map(resp, &(&1["name"]))

      assert Enum.all?(player_names, &Enum.member?(names_in_json, &1))
    end
  end
end
