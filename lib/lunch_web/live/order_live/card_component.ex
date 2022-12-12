defmodule LunchWeb.OrderLive.CardComponent do
  use LunchWeb, :live_component

  @impl true
  def handle_event("close_modal", _, socket) do
    # Go back to the :index live action
    {:noreply, push_patch(socket, to: Routes.order_index_path(socket, :index))}
  end
end
