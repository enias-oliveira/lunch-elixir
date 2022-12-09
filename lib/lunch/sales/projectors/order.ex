defmodule Lunch.Sales.Projectors.Order do
  use Commanded.Projections.Ecto,
    application: Lunch.Core.Application,
    name: "SalesProjectorsOrder",
    consistency: :strong

  alias Lunch.Sales.Events.OrderCreated
  alias Lunch.Sales.Order, as: OrderSchema

  project(%OrderCreated{id: id, customer_id: customer_id}, fn multi ->
    Ecto.Multi.insert(multi, :order, %OrderSchema{
      id: id,
      user_id: customer_id
    })
  end)
end
