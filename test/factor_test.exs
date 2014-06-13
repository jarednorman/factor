defmodule FactorTest do
  use ExUnit.Case

  test "it makes games happen" do
    game = Factor.new_game
    Factor.take_turn(game, :player_one, 2)
    Factor.take_turn(game, :player_two, 3)
    winner = Factor.end_turn(game)
    assert winner == :player_two
    Factor.take_turn(game, :player_one, 4)
    Factor.take_turn(game, :player_two, 1)
    winner = Factor.end_turn(game)
    assert winner == :player_one
  end
end
