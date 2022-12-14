defmodule Lunch.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :user_id, references(:users)
      add :status, :string

      timestamps()
    end
  end
end
