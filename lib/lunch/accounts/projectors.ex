defmodule Lunch.Accounts.Projectors.User do
  use Commanded.Projections.Ecto,
    application: Lunch.Core.Application,
    name: "AccountsProjectorsUser",
    consistency: :strong

  alias Lunch.Accounts.Events.UserRegistered

  alias Lunch.Accounts.User, as: UserSchema

  project(%UserRegistered{} = registered_user, fn multi ->
    Ecto.Multi.insert(multi, :user, %UserSchema{
      id: registered_user.id,
      name: registered_user.name,
      age: registered_user.age
    })
  end)
end
