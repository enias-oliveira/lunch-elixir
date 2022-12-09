defmodule Lunch.Sales.Commands do
  defmodule CreateOrder do
    defstruct [:id, :customer_id]

    use ExConstructor
  end
end
