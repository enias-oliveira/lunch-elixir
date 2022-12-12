defmodule Lunch.Sales.Projectors.Order do
  use Commanded.Projections.Ecto,
    application: Lunch.Core.Application,
    name: "SalesProjectorsOrder",
    consistency: :strong

  require Logger

  alias Lunch.Sales.Events.{OrderCreated, OrderStatusUpdated}
  alias Lunch.Sales.Order
  alias Lunch.Sales.Product
  alias Lunch.Repo

  project(
    %OrderCreated{id: id, customer_id: customer_id, products_ids: products_ids, status: status},
    fn multi ->
      products = Repo.all(from p in Product, where: p.id in ^products_ids)

      order =
        %Order{
          id: id,
          user_id: customer_id,
          status: String.to_atom(status)
        }
        |> Repo.preload(:products)
        |> Ecto.Changeset.change()
        |> Ecto.Changeset.put_assoc(:products, products)

      Ecto.Multi.insert(multi, :order, order)
    end
  )

  project(%OrderStatusUpdated{id: id, status: status}, fn multi ->
    changeset =
      Repo.get!(Order, id)
      |> Ecto.Changeset.change(status: String.to_atom(status))

    Ecto.Multi.update(multi, :order, changeset)
  end)

  @impl Commanded.Projections.Ecto
  def after_update(%OrderStatusUpdated{}, _metadata, %{order: order}) do
    Absinthe.Subscription.publish(LunchWeb.Endpoint, order, order_status_changed: order.id)

    :ok
  end
end
