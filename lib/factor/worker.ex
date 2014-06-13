defmodule Factor.Worker do
  use GenServer

  # Callbacks
  def start_link do
    :gen_server.start_link({ :local, :factor }, __MODULE__, [], [])
  end

  def init do
    { :ok, [] }
  end

  def handle_call(:new_game, _from, game_list) do
    game = new_game(game_list)
    { id, _ } = game
    { :reply, id, [ new_game(game_list) | game_list ] }
  end

  def handle_call({ :end_turn, id }, _from, game_list) do
    game = get_game(game_list, id)
    { winner, _move } = Factor.Game.winner(game)
    game = Factor.Game.end_turn(game)
    { :reply, winner, game_list }
  end

  def handle_cast({ :add_move, id, player, turn }, game_list) do
    game = get_game(game_list, id)
      |> Factor.Game.add_move(player, turn)
    { :noreply, update_game(game_list, id, game) }
  end

  # Private
  defp new_game(game_list) do
    id = unique_id(game_list)
    { id, Factor.Game.new }
  end

  defp unique_id([]), do: 0
  defp unique_id(game_list) do
    (game_list
      |> Enum.map(fn(game)-> elem(game, 0) end)
      |> Enum.max()) + 1
  end

  defp update_game(game_list, id, game) do
    [ { id, game } | Enum.reject(game_list, fn({ game_id, _ })->
        game_id == id
      end) ]
  end

  defp get_game(game_list, id) do
    { _id, game } = Enum.find(game_list, fn({ game_id, _game })->
      game_id == id
    end)
    game
  end
end
