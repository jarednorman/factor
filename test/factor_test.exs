defmodule FactorTest do
  use ExUnit.Case

  test "it makes games happen" do
    game = Factor.new_game
    Factor.add_move(game, :player_one, 2)
    Factor.add_move(game, :player_two, 3)
    winner = Factor.end_turn(game)
    assert winner == :player_two
    Factor.add_move(game, :player_one, 4)
    Factor.add_move(game, :player_two, 1)
    winner = Factor.end_turn(game)
    assert winner == :player_one
  end
end
