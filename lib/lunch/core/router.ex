defmodule Lunch.Core.Router do
  use Commanded.Commands.Router

  alias Lunch.Accounts.Aggregates.User
  alias Lunch.Accounts.Commands.RegisterUser

  alias Lunch.Sales.Aggregates.{Order, Product}
  alias Lunch.Sales.Commands.{CreateOrder, CreateProduct, UpdateOrderStatus}

  identify(User, by: :id, prefix: "user-")
  identify(Order, by: :id, prefix: "order-")
  identify(Product, by: :id, prefix: "product-")

  dispatch(RegisterUser, to: User)
  dispatch(CreateOrder, to: Order)
  dispatch(CreateProduct, to: Product)
  dispatch(UpdateOrderStatus, to: Order)
end
