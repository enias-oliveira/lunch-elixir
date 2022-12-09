defmodule Lunch.Accounts.Events do
  defmodule UserRegistered do
    @derive Jason.Encoder
    defstruct [
      :id,
      :name,
      :age
    ]
  end
end
