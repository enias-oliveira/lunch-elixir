defmodule Lunch.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Lunch.Sales

  @primary_key {:id, :binary_id, autogenerate: false}
  @foreign_key_type :binary_id

  schema "users" do
    field :age, :integer
    field :name, :string

    has_many :orders, Sales.Order

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :age])
    |> validate_required([:name, :age])
  end
end
