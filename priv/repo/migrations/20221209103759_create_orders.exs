defmodule Lunch.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :user_uuid, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:orders, [:user_uuid])
  end
end
