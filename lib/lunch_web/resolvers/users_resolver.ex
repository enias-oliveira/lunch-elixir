defmodule LunchWeb.Resolvers.UsersResolver do
  alias Lunch.Accounts

  def get_all(_root, _args, _info) do
    {:ok, Accounts.list_users()}
  end

  def create(_root, args, _info) do
    Accounts.create_user(args)
  end
end
