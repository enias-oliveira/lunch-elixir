defmodule Lunch.Accounts.Commands do
  defmodule RegisterUser do
    defstruct [
      :uuid,
      :name,
      :age
    ]

    use ExConstructor
  end
end
