defmodule Lunch.Sales.Projectors.Order do
  use Commanded.Projections.Ecto,
    application: Lunch.Core.Application,
    name: "SalesProjectorsOrder",
    consistency: :strong

  alias Lunch.Sales.Events.OrderCreated
  alias Lunch.Sales.Order, as: OrderSchema

  project(%OrderCreated{uuid: uuid, customer_uuid: customer_uuid}, fn multi ->
    Ecto.Multi.insert(multi, :order, %OrderSchema{
      uuid: uuid,
      user_uuid: customer_uuid
    })
  end)
end
