defmodule FactorWorkerTest do
  use ExUnit.Case

  test "it handles new_game events" do
    state = Factor.GameCollection.new

    { _, expected_state } = Factor.GameCollection.new
      |> Factor.GameCollection.add_game(Factor.Game.new)
    assert Factor.Worker.handle_call(:new_game, nil, state) ==
      { :reply, 0, expected_state }
  end

  test "it handles end_turn events" do
    game = Factor.Game.new
      |> Factor.Game.add_move(:johnny, 20)

    { _, state } = Factor.GameCollection.new
      |> Factor.GameCollection.add_game(game)

    game = Factor.Game.end_turn(game)
    { _, expected_state } = Factor.GameCollection.new
      |> Factor.GameCollection.add_game(game)

    assert Factor.Worker.handle_call({ :end_turn, 0 }, nil, state) ==
      { :reply, :johnny, expected_state }
  end
end
