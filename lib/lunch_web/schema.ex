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

  mutation do
    @desc "Create a user"
    field :create_user, :user do
      arg(:name, non_null(:string))
      arg(:age, non_null(:integer))

      resolve(&UsersResolver.create/3)
    end
  end
end
