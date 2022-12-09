defmodule Lunch.Sales.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: false}
  @foreign_key_type :binary_id

  schema "orders" do
    belongs_to :user, Lunch.Accounts.User
    many_to_many :products, Lunch.Sales.Product, join_through: "orders_products"

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [])
    |> validate_required([])
  end
end
