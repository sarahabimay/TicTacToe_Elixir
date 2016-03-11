defmodule TTT.BoardPlay do
  alias TTT.Board, as: Board

  def play_move(board, move, mark) do
    List.replace_at(board, move - 1, mark)
  end

  def next_mark_to_play(board) do
    board
    |> Board.rows
    |> count_each_mark
    |> mark_with_fewest_moves
  end

  def validate_move(board, move) do
    board
    |> Board.available_positions
    |> _validate_move(move)
  end

  defp _validate_move(positions, move) do
    Enum.find(positions, :invalid, is_move?(move))
  end

  defp is_move?(move) do
    fn(x) -> x == move end
  end

  defp count_each_mark(board) do
    [
      %{"X" => position_count_for_mark(board, "X")},
      %{"O" => position_count_for_mark(board, "O")}
    ]
  end

  defp mark_with_fewest_moves(mark_counts) do
    Enum.min_by(mark_counts, fn(x) -> Map.values(x) end)
    |> Map.keys
    |> List.to_string
  end

  defp position_count_for_mark(board, mark) do
    Enum.reduce(board, 0, fn(row, acc) -> acc + count_marks(row, mark)  end)
  end

  defp count_marks(row, mark) do
    Enum.count(row, fn(move) -> move == mark end)
  end
end
