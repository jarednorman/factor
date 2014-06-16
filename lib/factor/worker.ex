defmodule Factor.Worker do
  use GenServer

  # Callbacks
  def start_link do
    :gen_server.start_link({ :local, :factor }, __MODULE__, [], [])
  end

  def init do
    { :ok, Factor.GameCollection.new }
  end

  def handle_call(:new_game, _from, game_collection) do
    game = Factor.Game.new
    { id, game_collection } = Factor.GameCollection.add_game(game_collection, game)
    { :reply, id, game_collection }
  end

  def handle_call({ :end_turn, id }, _from, game_collection) do
    game = Factor.GameCollection.fetch_game(game_collection, id)
    { winner, _move } = Factor.Game.winner(game)
    game = Factor.Game.end_turn(game)
    game_collection = Factor.GameCollection.update_game(game_collection, id, game)
    { :reply, winner, game_collection }
  end

  def handle_cast({ :add_move, id, player, turn }, game_collection) do
    game = Factor.GameCollection.fetch_game(game_collection, id)
      |> Factor.Game.add_move(player, turn)
    game_collection = Factor.GameCollection.update_game(game_collection, id, game)
    { :noreply, game_collection }
  end
end
