defmodule Lunch.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :name, :string
      add :age, :integer

      timestamps()
    end
  end
end
