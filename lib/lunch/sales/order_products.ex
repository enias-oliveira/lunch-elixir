defmodule Lunch.Sales.OrderProducts do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "orders_products" do
    belongs_to :order, Lunch.Sales.Order
    belongs_to :product, Lunch.Sales.Product
  end

  def changeset(order_product, attrs) do
    order_product
    |> cast(attrs, [])
    |> validate_required([])
  end
end
