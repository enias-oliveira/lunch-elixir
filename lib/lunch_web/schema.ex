defmodule LunchWeb.Schema do
  use Absinthe.Schema

  alias LunchWeb.Resolvers.UsersResolver
  alias LunchWeb.Resolvers.Product, as: ProductResolver
  alias LunchWeb.Resolvers.Order, as: OrderResolver

  import Absinthe.Resolution.Helpers, only: [dataloader: 3, dataloader: 1]

  def context(ctx) do
    loader = Dataloader.new() |> Dataloader.add_source(Lunch, Lunch.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  object :user do
    field :id, non_null(:id)
    field :name, :string
    field :age, :integer
    field :orders, list_of(:order), resolve: dataloader(Lunch)
  end

  object :order do
    field :id, non_null(:id)

    field :customer, :user do
      resolve(dataloader(Lunch, :user, []))
    end

    field :products, list_of(:product) do
      resolve(dataloader(Lunch))
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

    @desc "Creates an order"
    field :create_order, :order do
      arg(:customer_id, non_null(:id))
      arg(:products_ids, non_null(list_of(:id)))

      resolve(&OrderResolver.create/3)
    end
  end
end
