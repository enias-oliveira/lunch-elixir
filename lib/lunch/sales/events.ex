defmodule Lunch.Sales.Events do
  defmodule OrderCreated do
    @derive Jason.Encoder
    defstruct [
      :id,
      :customer_id
    ]
  end
end
