defmodule Lunch.Sales.Events do
  defmodule OrderCreated do
    @derive Jason.Encoder
    defstruct [
      :id,
      :customer_id,
      :products_ids,
      :status
    ]
  end

  defmodule OrderStatusUpdated do
    @derive Jason.Encoder
    defstruct [
      :id,
      :status
    ]
  end

  defmodule ProductCreated do
    @derive Jason.Encoder
    defstruct [
      :id,
      :name,
      :price
    ]
  end

  defmodule ProductAddedToOrder do
    @derive Jason.Encoder
    defstruct [
      :order_id,
      :product_id
    ]
  end
end

defimpl Commanded.Serialization.JsonDecoder, for: Lunch.Sales.Events.OrderCreated do
  alias Lunch.Sales.Events.OrderCreated

  def decode(%OrderCreated{status: status} = event) do
    %OrderCreated{event | status: String.to_existing_atom(status)}
  end
end

defimpl Commanded.Serialization.JsonDecoder, for: Lunch.Sales.Events.OrderStatusUpdated do
  alias Lunch.Sales.Events.OrderStatusUpdated

  def decode(%OrderStatusUpdated{status: status} = event) do
    %OrderStatusUpdated{event | status: String.to_existing_atom(status)}
  end
end
