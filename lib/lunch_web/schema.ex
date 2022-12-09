defmodule LunchWeb.Schema do
  use Absinthe.Schema

  alias LunchWeb.Resolvers.UsersResolver
  alias Lunch.Accounts

  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  def context(ctx) do
    loader = Dataloader.new() |> Dataloader.add_source(Accounts.Queries, Accounts.Queries.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  object :user do
    field :uuid, non_null(:id)
    field :name, :string
    field :age, :integer
    field :orders, list_of(:order), resolve: dataloader(Accounts.Queries)
  end

  object :order do
    field :uuid, non_null(:id)

    field :customer, :user do
      resolve(dataloader(Accounts.Queries))
    end
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
