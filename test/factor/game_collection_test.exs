defmodule FactorGameCollectionTest do
  use ExUnit.Case

  test "you can add and fetch games to the collection" do
    collection = Factor.GameCollection.new
    game = Factor.Game.new
    { id, collection } = Factor.GameCollection.add_game(collection, game)
    assert Factor.GameCollection.fetch_game(collection, id) == game
  end

  test "you can update games in the collection" do
    collection = Factor.GameCollection.new

    game_one = Factor.Game.new |> Factor.Game.add_move(:cave, 10)
    game_two = Factor.Game.new |> Factor.Game.add_move(:potato, 30)
    game_three = Factor.Game.new |> Factor.Game.add_move(:trip, 30)

    { id, collection } = Factor.GameCollection.add_game(collection, game_one)
    { other_id, collection } = Factor.GameCollection.add_game(collection, game_three)
    collection = Factor.GameCollection.update_game(collection, id, game_two)
    assert Factor.GameCollection.fetch_game(collection, id) == game_two
    assert Factor.GameCollection.fetch_game(collection, other_id) == game_three
  end
end
