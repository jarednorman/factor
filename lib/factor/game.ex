defmodule Factor.Game do
  def new do
    [[]]
  end

  def get_turn([current_turn|_other_turns]), do: current_turn

  def add_move([current_turn|other_turns], move) do
    [[move | current_turn] | other_turns]
  end

  def get_moves([current_turn|_other_turns]), do: current_turn

  def end_turn(game), do: [[] | game]
end
