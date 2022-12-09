defmodule Lunch.Accounts.Queries do
  def data() do
    Dataloader.Ecto.new(Lunch.Repo, query: &query/2)
  end

  def query(queryable, _params) do
    queryable
  end
end
