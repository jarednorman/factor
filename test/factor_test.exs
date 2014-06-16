defmodule FactorTest do
  use ExUnit.Case

  test "it makes games happen" do
    game_one = Factor.new_game

    Factor.add_move(game_one, :john, 3)
    winner = Factor.end_turn(game_one)
    assert winner == :john

    game_two = Factor.new_game

    Factor.add_move(game_one, :jared, 4)
    Factor.add_move(game_one, :alistair, 1)
    winner = Factor.end_turn(game_one)
    assert winner == :jared

    Factor.add_move(game_two, :amy, 4)
    Factor.add_move(game_two, :cave, 5)
    Factor.add_move(game_two, :gordon, 100)
    Factor.add_move(game_two, :denis, 12)
    winner = Factor.end_turn(game_two)
    assert winner == :gordon

    Factor.add_move(game_one, :amy, 4)
    Factor.add_move(game_one, :denis, 12)
    winner = Factor.end_turn(game_one)
    assert winner == :denis
  end
end
