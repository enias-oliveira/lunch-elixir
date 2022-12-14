defmodule Lunch.Sales do
  @moduledoc """
  The Sales context.
  """

  import Ecto.Query, warn: false
  alias Lunch.Repo

  alias Lunch.Sales.{Order, Product}

  alias Lunch.Sales.Commands.{CreateOrder, CreateProduct, UpdateOrderStatus, AddProductToOrder}

  alias Lunch.Core

  alias Lunch.Accounts

  alias Lunch.Accounts.User

  @topic inspect(__MODULE__)

  def subscribe_to_orders() do
    Phoenix.PubSub.subscribe(Lunch.PubSub, @topic)
  end

  def notify_order_status_updated(order) do
    Phoenix.PubSub.broadcast(Lunch.PubSub, @topic, {:order_status_changed, order.id})
  end

  @doc """
  Returns the list of orders.

  ## Examples

      iex> list_orders()
      [%Order{}, ...]

  """
  def list_orders do
    Repo.all(Order) |> Repo.preload([:user, :products])
  end

  @doc """
  Gets a single order.

  Raises `Ecto.NoResultsError` if the Order does not exist.

  ## Examples

      iex> get_order!(123)
      %Order{}

      iex> get_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order!(id), do: Repo.get!(Order, id)

  @doc """
  Creates a order.

  ## Examples

      iex> create_order(%{field: value})
      {:ok, %Order{}}

      iex> create_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order(attrs \\ %{}) do
    order = CreateOrder.new(Map.merge(attrs, %{id: Ecto.UUID.generate(), status: :pending}))

    dispatch_order = fn ->
      order
      |> Core.Application.dispatch(consistency: :strong)
    end

    with %Accounts.User{} <- Repo.get(User, order.customer_id),
         {:is_products, true} <- {:is_products, all_products_exist(order.products_ids)},
         :ok <- dispatch_order.(),
         %Order{} = order <- Repo.get(Order, order.id) do
      {:ok, order}
    else
      {:is_products, false} ->
        {:error, :products_not_found}

      err ->
        {:error, err}
    end
  end

  @doc """
  Updates a order.

  ## Examples

      iex> update_order(order, %{field: new_value})
      {:ok, %Order{}}

      iex> update_order(order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_order(%Order{} = order, attrs) do
    order
    |> Order.changeset(attrs)
    |> Repo.update()
  end

  def update_order_status_by_id(id, status) do
    command = UpdateOrderStatus.new(%{id: id, status: status})

    with {:is_order, true} <- {:is_order, !!Repo.get(Order, command.id)},
         :ok <- Core.Application.dispatch(command, consistency: :strong),
         %Order{} = order <- Repo.get(Order, id) do
      {:ok, order}
    else
      {:is_order, false} ->
        {:error, :order_not_found}

      err ->
        {:error, err}
    end
  end

  @doc """
  Deletes a order.

  ## Examples

      iex> delete_order(order)
      {:ok, %Order{}}

      iex> delete_order(order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_order(%Order{} = order) do
    Repo.delete(order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order changes.

  ## Examples

      iex> change_order(order)
      %Ecto.Changeset{data: %Order{}}

  """
  def change_order(%Order{} = order, attrs \\ %{}) do
    Order.changeset(order, attrs)
  end

  def add_product_to_order(attrs \\ %{}) do
    command = AddProductToOrder.new(attrs)

    with {:is_order, true} <- {:is_order, !!Repo.get(Order, command.id)},
         {:is_product, true} <- {:is_product, !!Repo.get(Product, command.product_id)},
         :ok <- Core.Application.dispatch(command, consistency: :strong),
         %Order{} = order <- Repo.get(Order, command.id) do
      {:ok, order}
    else
      {:is_order, false} ->
        {:error, :order_not_found}

      {:is_product, false} ->
        {:error, :product_not_found}

      {:error, err} ->
        {:error, err}
    end
  end

  alias Lunch.Sales.Product

  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_products do
    Repo.all(Product)
  end

  @doc """
  Gets a single product.

  Raises `Ecto.NoResultsError` if the Product does not exist.

  ## Examples

      iex> get_product!(123)
      %Product{}

      iex> get_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product!(id), do: Repo.get!(Product, id)

  @doc """
  Creates a product.

  ## Examples

      iex> create_product(%{field: value})
      {:ok, %Product{}}

      iex> create_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product(attrs \\ %{}) do
    product = CreateProduct.new(Map.put(attrs, :id, Ecto.UUID.generate()))

    dispatch_product = fn ->
      product
      |> Core.Application.dispatch(consistency: :strong)
    end

    with :ok <- dispatch_product.(),
         %Product{} = product <- Repo.get(Product, product.id) do
      {:ok, product}
    else
      err ->
        {:error, err}
    end
  end

  @doc """
  Updates a product.

  ## Examples

      iex> update_product(product, %{field: new_value})
      {:ok, %Product{}}

      iex> update_product(product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product.

  ## Examples

      iex> delete_product(product)
      {:ok, %Product{}}

      iex> delete_product(product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  ## Examples

      iex> change_product(product)
      %Ecto.Changeset{data: %Product{}}

  """
  def change_product(%Product{} = product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end

  defp all_products_exist(ids) do
    query = from p in Product, where: p.id in ^ids, select: p.id
    existing_ids = Repo.all(query) |> MapSet.new()

    ids |> MapSet.new() |> MapSet.subset?(existing_ids)
  end
end
