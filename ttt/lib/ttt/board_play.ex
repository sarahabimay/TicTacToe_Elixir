defmodule TTT.BoardPlay do
  alias TTT.Board, as: Board

  def play_move(board, move, mark) do
    List.replace_at(board, move - 1, mark)
  end

  def validate_move(board, move) do
    max_position = Enum.count(board)
    _validate_move(Integer.parse(move), max_position)
  end

  def next_mark_to_play(board) do
    board
    |> Board.rows
    |> count_each_mark
    |> mark_with_fewest_moves
  end

  defp count_each_mark(board) do
    [
      %{"X" => position_count_for_mark(board, "X")},
      %{"O" => position_count_for_mark(board, "O")}
    ]
  end

  def mark_with_fewest_moves(mark_counts) do
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

  defp _validate_move(:error, _), do: :invalid
  defp _validate_move({x, _}, max_position) when x > 0 and x <= max_position, do: x
  defp _validate_move(_, _), do: :invalid
end
