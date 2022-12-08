defmodule LunchWeb.Schema do
  use Absinthe.Schema

  alias LunchWeb.Resolvers.UsersResolver

  object :user do
    field :uuid, non_null(:id)
    field :name, :string
    field :age, :integer
  end

  query do
    @desc "Get all users"
    field :all_users, list_of(:user) do
      resolve(&UsersResolver.get_all/3)
    end
  end
end
