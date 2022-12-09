defmodule Lunch.SalesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lunch.Sales` context.
  """

  @doc """
  Generate a order.
  """
  def order_fixture(attrs \\ %{}) do
    {:ok, order} =
      attrs
      |> Enum.into(%{

      })
      |> Lunch.Sales.create_order()

    order
  end

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        name: "some name",
        price: 42
      })
      |> Lunch.Sales.create_product()

    product
  end
end
