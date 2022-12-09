defmodule LunchWeb.Schema do
  use Absinthe.Schema

  alias LunchWeb.Resolvers.UsersResolver
  alias Lunch.Accounts
  alias LunchWeb.Resolvers.Product, as: ProductResolver

  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  def context(ctx) do
    loader = Dataloader.new() |> Dataloader.add_source(Accounts.Queries, Accounts.Queries.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  object :user do
    field :id, non_null(:id)
    field :name, :string
    field :age, :integer
    field :orders, list_of(:order), resolve: dataloader(Accounts.Queries)
  end

  object :order do
    field :id, non_null(:id)

    field :customer, :user do
      resolve(dataloader(Accounts.Queries))
    end
  end

  object :product do
    field :id, non_null(:id)
    field :name, :string
    field :price, :float
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

    @desc "Creates an product"
    field :create_product, :product do
      arg(:name, non_null(:string))
      arg(:price, non_null(:integer))

      resolve(&ProductResolver.create/3)
    end
  end
end
