defmodule Factor do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [] #[ worker(Factor.Worker, []) ]
    opts = [strategy: :one_for_one, name: Factor.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
