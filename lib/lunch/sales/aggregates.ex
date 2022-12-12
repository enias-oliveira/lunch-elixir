defmodule Lunch.Sales.Aggregates do
  defmodule Order do
    defstruct [
      :id,
      :customer_id,
      :products_ids,
      :status
    ]

    alias Lunch.Sales.Commands.{CreateOrder, UpdateOrderStatus, AddProductToOrder}
    alias Lunch.Sales.Events.{OrderCreated, OrderStatusUpdated, ProductAddedToOrder}

    def execute(%Order{}, %CreateOrder{} = command) do
      %OrderCreated{
        id: command.id,
        customer_id: command.customer_id,
        products_ids: command.products_ids,
        status: command.status
      }
    end

    def execute(%Order{id: id}, %UpdateOrderStatus{status: status}) do
      %OrderStatusUpdated{
        id: id,
        status: status
      }
    end

    def execute(%Order{status: current_status}, %AddProductToOrder{
          id: order_id,
          product_id: product_id
        }) do
      case current_status do
        :completed ->
          {:error, "Order is already completed"}

        :pending ->
          %ProductAddedToOrder{
            order_id: order_id,
            product_id: product_id
          }
      end
    end

    def apply(%Order{} = order, %OrderCreated{} = event) do
      %Order{
        order
        | id: event.id,
          customer_id: event.customer_id,
          products_ids: event.products_ids,
          status: event.status
      }
    end

    def apply(%Order{} = order, %OrderStatusUpdated{} = event) do
      %Order{
        order
        | status: event.status
      }
    end

    def apply(%Order{products_ids: products_ids} = order, %ProductAddedToOrder{} = event) do
      %Order{
        order
        | products_ids: [event.product_id | products_ids]
      }
    end
  end

  defmodule Product do
    defstruct [
      :id,
      :name,
      :price
    ]

    alias Lunch.Sales.Commands.CreateProduct
    alias Lunch.Sales.Events.ProductCreated

    def execute(%Product{}, %CreateProduct{} = command) do
      %ProductCreated{
        id: command.id,
        name: command.name,
        price: command.price
      }
    end

    def apply(%Product{}, %ProductCreated{} = event) do
      %Product{
        id: event.id,
        name: event.name,
        price: event.price
      }
    end
  end
end
