defmodule GameConsolePresentation do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: GameConsolePresentation.Worker.start_link(arg1, arg2, arg3)
      # worker(GameConsolePresentation.Worker, [arg1, arg2, arg3]),
      supervisor(GameConsolePresentation.Repo, []),
      worker(Commanded.Event.Handler, ["player_status", GameConsolePresentation.ActivePlayers.Projector], id: :active_players)
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GameConsolePresentation.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
