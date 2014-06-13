defmodule Factor do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    children = [ worker(Factor.Worker, []) ]
    opts = [strategy: :one_for_one, name: Factor.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def new_game do
    GenServer.call(:factor, :new_game)
  end

  def add_move(game, player, turn) do
    GenServer.cast(:factor, { :add_move, game, player, turn })
  end

  def end_turn(game) do
    GenServer.call(:factor, { :end_turn, game })
  end
end
