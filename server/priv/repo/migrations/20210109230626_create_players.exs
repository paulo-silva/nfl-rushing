defmodule Server.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add(:name, :string, null: false)
      add(:team, :string, null: false)
      add(:position, :string, null: false)
      add(:attempts_avg, :float, null: false)
      add(:attempts, :integer, null: false)
      add(:total_yards, :float, null: false)
      add(:avg_yards_per_attempts, :float, null: false)
      add(:yards_per_game, :float, null: false)
      add(:total_touchdowns, :integer, null: false)
      add(:longest_rush, :string, null: false)
      add(:first_down, :integer, null: false)
      add(:first_down_ratio, :float, null: false)
      add(:twenty_yards, :integer, null: false)
      add(:fourty_yards, :integer, null: false)
      add(:fumbles, :integer, null: false)

      timestamps()
    end

    create(index(:players, :name))
  end
end
