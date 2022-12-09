defmodule LunchWeb.Resolvers.Order do
  alias Lunch.Sales

  def get_all(_root, _args, _info) do
    Sales.list_orders()
  end

  def create(_root, args, _info) do
    Sales.create_order(args)
  end
end
