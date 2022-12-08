defmodule LunchWeb.Resolvers.UsersResolver do
  alias Lunch.Accounts

  def get_all(_root, _args, _info) do
    Accounts.list_users()
  end
end
