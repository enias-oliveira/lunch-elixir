defmodule Lunch.Sales.Events do
  defmodule OrderCreated do
    @derive Jason.Encoder
    defstruct [
      :id,
      :customer_id,
      :products_ids
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
end
