defmodule Lunch.Sales.Aggregates do
  defmodule Order do
    defstruct [
      :id,
      :customer_id
    ]

    alias Lunch.Sales.Commands.CreateOrder
    alias Lunch.Sales.Events.OrderCreated

    def execute(%Order{}, %CreateOrder{} = command) do
      %OrderCreated{
        id: command.id,
        customer_id: command.customer_id
      }
    end

    def apply(%Order{}, %OrderCreated{} = event) do
      %Order{
        id: event.id,
        customer_id: event.customer_id
      }
    end
  end
end
