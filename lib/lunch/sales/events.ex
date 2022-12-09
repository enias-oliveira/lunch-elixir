defmodule Lunch.Sales.Events do
  defmodule OrderCreated do
    @derive Jason.Encoder
    defstruct [
      :uuid,
      :customer_uuid
    ]
  end
end
