defmodule Lunch.Sales.Commands do
  defmodule CreateOrder do
    defstruct [:id, :customer_id, :products_ids]

    use ExConstructor
  end

  defmodule CreateProduct do
    defstruct [:id, :name, :price]

    use ExConstructor
  end
end
