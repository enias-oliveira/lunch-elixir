# Lunch

Dependecies: 

- 2 Postgress Databases, setup on `config/dev.exs`. I recommend using Railway (In the future I will add local databases using nix)
- Elixir 1.12: Install it or use [`Nix`](https://nixos.wiki/wiki/Flakes) with `nix develop`

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Setup EventStore database with `mix do event_store.create, event_store.init`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`
  
Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Usage: 

Follow these steps to access all features

- Create a user 
- Create a Product
- Create a Order
- Add a Product to a pending order by passing the product id
- Complete Order
- Adding a Product to a complete order will show a modal with error


GraphQL playground available at [`GraphiQL`](http://localhost:4000/dev/graphiql)

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
