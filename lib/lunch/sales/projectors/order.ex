defmodule Lunch.Sales.Projectors.Order do
  use Commanded.Projections.Ecto,
    application: Lunch.Core.Application,
    name: "SalesProjectorsOrder",
    consistency: :strong

  require Logger

  alias Lunch.Sales.Events.OrderCreated
  alias Lunch.Sales.Order
  alias Lunch.Sales.Product
  alias Lunch.Repo

  project(%OrderCreated{id: id, customer_id: customer_id, products_ids: products_ids}, fn multi ->
    products = Repo.all(from p in Product, where: p.id in ^products_ids)

    order =
      %Order{
        id: id,
        user_id: customer_id
      }
      |> Repo.preload(:products)
      |> Ecto.Changeset.change()
      |> Ecto.Changeset.put_assoc(:products, products)

    Ecto.Multi.insert(multi, :order, order)
  end)
end
