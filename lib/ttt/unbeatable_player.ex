defmodule TTT.UnbeatablePlayer do
  alias TTT.Negamax
  alias TTT.Board

  def next_move(board, _) do
    Negamax.negamax(remaining_spaces(board), board, -10000000, 10000000)[:best_move]
  end

  defp remaining_spaces(board) do
    Enum.count(Board.available_positions(board))
  end
end
