defmodule LunchWeb.Resolvers.Order do
  alias Lunch.Sales

  def get_all(_root, _args, _info) do
    Sales.list_orders()
  end

  def create(_root, args, _info) do
    Sales.create_order(args)
  end

  def update_status(_root, %{order_id: id, status: status}, _info) do
    Sales.update_order_status_by_id(id, status)
  end

  def add_product(_root, args, _info) do
    Sales.add_product_to_order(%{id: args.order_id, product_id: args.product_id})
  end
end
