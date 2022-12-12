defmodule LunchWeb.OrderLive.Index do
  use LunchWeb, :live_view

  alias Lunch.Sales
  alias Lunch.Sales.Order

  @impl true
  def mount(_params, _session, socket) do
    Lunch.Sales.subscribe_to_orders()

    {:ok, assign(socket, :orders, list_orders())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Order")
    |> assign(:order, Sales.get_order!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Order")
    |> assign(:order, %Order{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Orders")
    |> assign(:order, nil)
  end

  defp apply_action(socket, :modal, _params) do
    socket
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    order = Sales.get_order!(id)
    {:ok, _} = Sales.delete_order(order)

    {:noreply, assign(socket, :orders, list_orders())}
  end

  @impl true
  def handle_event("close_modal", _, socket) do
    {:noreply, push_patch(socket, to: Routes.order_index_path(socket, :index))}
  end

  @impl true
  def handle_event("complete", %{"value" => id}, socket) do
    Lunch.Sales.update_order_status_by_id(id, :completed)

    {:noreply, socket}
  end

  @impl true
  def handle_event("validate", %{"add_product" => params}, socket) do
    case params["product_id"] do
      "" ->
        {:noreply, socket}

      product_id ->
        {:noreply, socket |> assign(:product_id, product_id)}
    end
  end

  @impl true
  def handle_event("add_product", %{"add_product" => params}, socket) do
    IO.inspect(params)

    case Sales.add_product_to_order(%{id: params["order_id"], product_id: params["product_id"]}) do
      {:ok, _} ->
        {:noreply, assign(socket, :orders, list_orders())}

      {:error, "Order is already completed"} ->
        {:noreply, push_patch(socket, to: Routes.order_index_path(socket, :modal))}
    end
  end

  @impl true
  def handle_info({:order_status_changed, _}, socket) do
    {:noreply, assign(socket, :orders, list_orders())}
  end

  defp list_orders do
    Sales.list_orders()
  end
end
