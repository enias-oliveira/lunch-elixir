defmodule Lunch.Core.Router do
  use Commanded.Commands.Router

  alias Lunch.Accounts.Aggregates.User
  alias Lunch.Accounts.Commands.RegisterUser

  alias Lunch.Sales.Aggregates.Order
  alias Lunch.Sales.Commands.CreateOrder

  identify(User, by: :uuid, prefix: "user-")
  identify(Order, by: :uuid, prefix: "order-")

  dispatch(RegisterUser, to: User)
  dispatch(CreateOrder, to: Order)
end
