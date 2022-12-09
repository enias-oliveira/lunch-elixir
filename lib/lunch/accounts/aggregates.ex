defmodule Lunch.Accounts.Aggregates do
  defmodule User do
    defstruct [
      :id,
      :name,
      :age
    ]

    alias Lunch.Accounts.Commands.RegisterUser
    alias Lunch.Accounts.Events.UserRegistered

    @doc """
    Register a new user.
    """
    def execute(%User{id: nil}, %RegisterUser{} = register_command) do
      %UserRegistered{
        id: register_command.id,
        name: register_command.name,
        age: register_command.age
      }
    end

    def apply(%User{} = _user, %UserRegistered{} = registered_user) do
      %User{
        id: registered_user.id,
        name: registered_user.name,
        age: registered_user.age
      }
    end
  end
end
