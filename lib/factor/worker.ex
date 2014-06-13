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
    { :reply, 1, [ new_game(game_list) | game_list ] }
  end

  def handle_call({ :end_turn, _game }, _from, game_list) do
    { :reply, :player_two, game_list }
  end

  def handle_cast({ :take_turn, id, player, turn }, game_list) do
    new_turn = { player, turn }
    IO.puts game_list
    { _id, _turns } = get_game(game_list, id)
    { :noreply, game_list }
  end

  # Private
  defp new_game(game_list) do
    id = unique_id(game_list)
    turns = [ [] ]
    { id, turns }
  end

  defp unique_id([]), do: 0
  defp unique_id(game_list) do
    (game_list
      |> Enum.map(fn(game)-> elem(game, 0) end)
      |> Enum.max()) + 1
  end

  defp update_game(game_list, id, state) do
    [ { id, state } | Enum.reject(game_list, fn({ game_id, _ })->
        game_id == id
      end) ]
  end

  defp get_game(game_list, id) do
    Enum.find(game_list, fn({ game_id, _turns })->
      game_id == id 
    end)
  end
end
