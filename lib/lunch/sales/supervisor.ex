defmodule Lunch.Sales.Supervisor do
  use Supervisor

  alias Lunch.Sales.Projectors.{Order, Product}

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(_arg) do
    Supervisor.init(
      [
        Product,
        Order
      ],
      strategy: :one_for_one
    )
  end
end
