defmodule Lunch.Accounts.Aggregates do
  defmodule User do
    defstruct [
      :uuid,
      :name,
      :age
    ]

    alias Lunch.Accounts.Commands.RegisterUser
    alias Lunch.Accounts.Events.UserRegistered

    @doc """
    Register a new user.
    """
    def execute(%User{uuid: nil}, %RegisterUser{} = register_command) do
      %UserRegistered{
        uuid: register_command.uuid,
        name: register_command.name,
        age: register_command.age
      }
    end

    def apply(%User{} = _user, %UserRegistered{} = registered_user) do
      %User{
        uuid: registered_user.uuid,
        name: registered_user.name,
        age: registered_user.age
      }
    end
  end
end
