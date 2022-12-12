defmodule LunchWeb.OrderSocket do
  use Phoenix.Socket

  use Absinthe.Phoenix.Socket,
    schema: LunchWeb.Schema

  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
