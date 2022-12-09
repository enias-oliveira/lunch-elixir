defmodule Lunch.Sales.Projectors.Product do
  use Commanded.Projections.Ecto,
    application: Lunch.Core.Application,
    name: "SalesProjectorsProduct",
    consistency: :strong

  alias Lunch.Sales.Events.ProductCreated
  alias Lunch.Sales.Product, as: ProductSchema

  project(%ProductCreated{id: id, name: name, price: price}, fn multi ->
    Ecto.Multi.insert(multi, :product, %ProductSchema{
      id: id,
      name: name,
      price: price
    })
  end)
end
