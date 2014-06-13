defmodule FactorWorkerTest do
  use ExUnit.Case

  test "it handles new_game events" do
    assert Factor.Worker.handle_call(:new_game, pid, []) ==
      { :reply, 0, [{0, Factor.Game.new}] }
  end

  test "it handles end_turn events" do
    game = Factor.Game.new
      |> Factor.Game.add_move(:johnny, 20)
    assert Factor.Worker.handle_call({ :end_turn, 0 }, pid, [game]) ==
      { :reply, :johnny, [ Factor.Game.end_turn(game) ] }
  end

  defp pid, do: self()
end
