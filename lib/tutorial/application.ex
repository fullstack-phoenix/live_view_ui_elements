defmodule Tutorial.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      TutorialWeb.Telemetry,
      # Start the Ecto repository
      Tutorial.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Tutorial.PubSub},
      # Start Finch
      {Finch, name: Tutorial.Finch},
      # Start the Endpoint (http/https)
      TutorialWeb.Endpoint
      # Start a worker by calling: Tutorial.Worker.start_link(arg)
      # {Tutorial.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Tutorial.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TutorialWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
