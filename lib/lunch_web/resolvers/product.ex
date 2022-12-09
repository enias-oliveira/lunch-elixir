defmodule LunchWeb.Resolvers.Product do
  alias Lunch.Sales

  def get_all(_root, _args, _info) do
    Sales.list_products()
  end

  def create(_root, args, _info) do
    Sales.create_product(args)
  end
end
