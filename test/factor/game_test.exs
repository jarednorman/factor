defmodule FactorGameTest do
  use ExUnit.Case

  test "new games have an initial turn" do
    game = Factor.Game.new
    assert Factor.Game.get_turn(game) == []
  end

  test "you can add moves" do
    game = Factor.Game.new
    game = Factor.Game.add_move(game, :cave, 10)
    assert Factor.Game.get_moves(game) == [ { :cave, 10 } ]
  end

  test "you can take multiple turns" do
    game = Factor.Game.new
      |> Factor.Game.add_move(:playername, 10)
      |> Factor.Game.end_turn
      |> Factor.Game.add_move(:cave_johnson, 30)
      |> Factor.Game.add_move(:john_hawthorn, 80)
    assert Factor.Game.get_moves(game) == [
      { :john_hawthorn, 80 }, { :cave_johnson, 30 }
    ]
  end

  test "it can determine the current winner" do
    game = Factor.Game.new
      |> Factor.Game.add_move(:cave_johnson, 30)
      |> Factor.Game.add_move(:john_hawthorn, 80)
    assert Factor.Game.winner(game) == { :john_hawthorn, 80 }
  end
end
