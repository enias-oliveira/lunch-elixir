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
end
