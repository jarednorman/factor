defmodule FactorGameTest do
  use ExUnit.Case

  test "new games have an initial turn" do
    game = Factor.Game.new
    assert Factor.Game.get_turn(game) == []
  end

  test "you can add moves" do
    game = Factor.Game.new
    move = {:playername, 10}
    game = Factor.Game.add_move(game, move)
    assert Factor.Game.get_moves(game) == [{:playername, 10}]
  end

  test "you can take multiple turns" do
    move_one = {:playername, 10}
    move_two = {:cave_johnson, 30}
    move_three = {:john_hawthorn, 80}
    game = Factor.Game.new
      |> Factor.Game.add_move(move_one)
      |> Factor.Game.end_turn
      |> Factor.Game.add_move(move_two)
      |> Factor.Game.add_move(move_three)
    assert Factor.Game.get_moves(game) == [
      {:john_hawthorn, 80}, {:cave_johnson, 30}
    ]
  end
end
