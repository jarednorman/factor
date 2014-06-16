defmodule Factor.GameCollection do
  def new do
    []
  end

  def add_game(collection, game) do
    id = unique_id(collection)
    collection = [ { id, game } | collection ]
    { id, collection }
  end

  def fetch_game(collection, id) do
    { _id, game } = Enum.find(collection, fn({ game_id, _game })->
      game_id == id
    end)
    game
  end

  def update_game(collection, id, new_game) do
    Enum.map(collection, fn({ game_id, game }) ->
      if game_id == id do
        { id, new_game }
      else
        { game_id, game }
      end
    end)
  end

  # Private
  defp unique_id([]), do: 0
  defp unique_id(collection) do
    (collection
      |> Enum.map(fn(game)-> elem(game, 0) end)
      |> Enum.max()) + 1
  end
end
