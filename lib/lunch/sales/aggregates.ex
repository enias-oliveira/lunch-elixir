defmodule Lunch.Sales.Aggregates do
  defmodule Order do
    defstruct [
      :id,
      :customer_id,
      :products_ids
    ]

    alias Lunch.Sales.Commands.CreateOrder
    alias Lunch.Sales.Events.OrderCreated

    require Logger

    def execute(%Order{}, %CreateOrder{} = command) do
      %OrderCreated{
        id: command.id,
        customer_id: command.customer_id,
        products_ids: command.products_ids
      }
    end

    def apply(%Order{}, %OrderCreated{} = event) do
      %Order{
        id: event.id,
        customer_id: event.customer_id,
        products_ids: event.products_ids
      }
    end
  end

  defmodule Product do
    defstruct [
      :id,
      :name,
      :price
    ]

    alias Lunch.Sales.Commands.CreateProduct
    alias Lunch.Sales.Events.ProductCreated

    def execute(%Product{}, %CreateProduct{} = command) do
      %ProductCreated{
        id: command.id,
        name: command.name,
        price: command.price
      }
    end

    def apply(%Product{}, %ProductCreated{} = event) do
      %Product{
        id: event.id,
        name: event.name,
        price: event.price
      }
    end
  end
end
