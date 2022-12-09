defmodule Lunch.Sales.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: false}
  @foreign_key_type :binary_id

  schema "products" do
    field :name, :string
    field :price, :integer

    many_to_many :orders, Lunch.Sales.Order, join_through: "orders_products"

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :price])
  end
end
