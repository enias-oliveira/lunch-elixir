defmodule Lunch.Core.Router do
  use Commanded.Commands.Router

  alias Lunch.Accounts.Aggregates.User

  alias Lunch.Accounts.Commands.RegisterUser

  identify(User, by: :uuid, prefix: "user-")

  dispatch(RegisterUser, to: User)
end
