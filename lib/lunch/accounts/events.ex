defmodule Lunch.Accounts.Events do
  defmodule UserRegistered do
    @derive Jason.Encoder
    defstruct [
      :uuid,
      :name,
      :age
    ]
  end
end
