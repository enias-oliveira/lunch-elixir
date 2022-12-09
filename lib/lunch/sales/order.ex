defmodule Lunch.Sales.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:uuid, :binary_id, autogenerate: false}
  @foreign_key_type :binary_id

  schema "orders" do
    belongs_to :user, Lunch.Accounts.User, foreign_key: :user_uuid

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [])
    |> validate_required([])
  end
end
