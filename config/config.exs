# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :hellophoenix,
  ecto_repos: [Hellophoenix.Repo]

# Configures the endpoint
config :hellophoenix, HellophoenixWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "8bkLar+cO5CIAI0e24PJp/i//lFo+2796MUmGbSNqP0JXg9m+cRZSmZjfhbUlTPa",
  render_errors: [view: HellophoenixWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Hellophoenix.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
