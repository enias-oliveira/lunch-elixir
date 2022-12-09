defmodule Lunch.Sales.Aggregates do
  defmodule Order do
    defstruct [
      :uuid,
      :customer_uuid
    ]

    alias Lunch.Sales.Commands.CreateOrder
    alias Lunch.Sales.Events.OrderCreated

    def execute(%Order{}, %CreateOrder{} = command) do
      %OrderCreated{
        uuid: command.uuid,
        customer_uuid: command.customer_uuid
      }
    end

    def apply(%Order{}, %OrderCreated{} = event) do
      %Order{
        uuid: event.uuid,
        customer_uuid: event.customer_uuid
      }
    end
  end
end
