defmodule Lunch.Accounts.Commands do
  defmodule RegisterUser do
    defstruct [
      :id,
      :name,
      :age
    ]

    use ExConstructor
  end
end
