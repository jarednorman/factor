defmodule Factor.Game do
  def new do
    [[]]
  end

  def get_turn([ current_turn | _other_turns ]), do: current_turn

  def add_move([ current_turn | other_turns ], player, move) do
    [ [ { player, move } | current_turn ] | other_turns ]
  end

  def get_moves([ current_turn | _other_turns ]), do: current_turn

  def winner([ current_turn | _other_turns ]) do
    current_turn
      |> Enum.max_by(fn(move)-> elem(move, 1) end)
  end

  def end_turn(game), do: [ [] | game ]
end
