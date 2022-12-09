defmodule Lunch.Sales.Commands do
  defmodule CreateOrder do
    defstruct [:uuid, :customer_uuid]

    use ExConstructor
  end
end
