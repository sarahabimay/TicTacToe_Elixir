defmodule TTT.Board do
  def empty_board(dimension) do
    Enum.to_list(1..dimension*dimension)
  end

  def play_move(board, move, mark) do
    List.replace_at(board, move - 1, mark)
  end

  def next_mark_to_play(board, marks) do
    get_move_count_per_mark(board, marks)
    |> mark_with_fewest_moves
  end

  def game_over?(board, marks) do
    not remaining_spaces?(board, marks)
  end

  def winning_mark(board) do
    winning_mark_in_row(board) <>
     winning_mark_in_column(board) <>
      winning_mark_in_diagonal(board)
  end

  def found_winner?(board) do
    Enum.any?(win_in_any_direction?(board), is_true?)
  end

  defp win_in_any_direction?(board) do
    [column_win?(board), row_win?(board), diagonal_win?(board)]
  end

  defp winning_mark_in_diagonal(board) do
    diagonal_marks(board)
    |> winning_mark_in_row
  end

  defp winning_mark_in_column(board) do
    transpose(board)
    |> winning_mark_in_row
  end

  defp winning_mark_in_row([]), do: ""
  defp winning_mark_in_row([row | tail]) do
    if not all_same_mark?([mark | _] = row) do
      winning_mark_in_row(tail)
    else
      mark
    end
  end

  def all_same_mark?([mark | t]) do
    Enum.all?(t, fn(move) -> move == mark end)
  end

  def row_win?(board) do
    found_winner_in_row?(board)
  end

  def column_win?(board) do
    transpose(board)
    |> row_win?
  end

  def diagonal_win?(board) do
    diagonal_marks(board)
    |> row_win?
  end

  defp found_winner_in_row?([], all_same), do: all_same
  defp found_winner_in_row?(_, true), do: true
  defp found_winner_in_row?([head | tail], false) do
    found_winner_in_row?(tail, all_same_mark?(head))
  end
  def found_winner_in_row?(board) do
    found_winner_in_row?(board, false)
  end

  defp remaining_spaces?(board, marks) do
    count_of_all_mark_moves(board, marks) < length(board)
  end

  defp count_of_all_mark_moves(board, marks) do
    get_move_count_per_mark(board, marks)
    |> total_moves_made
  end

  defp get_move_count_per_mark(board, marks) do
    Enum.map(marks, fn(mark) ->
      %{mark => position_count_for_mark(board, mark)}
    end)
  end

  def position_count_for_mark(board, mark) do
    Enum.reduce(board, 0, fn(row, acc) -> acc + Enum.count(row, fn(move) -> move == mark end) end)
  end

  defp total_moves_made(move_count) do
    Enum.reduce(move_count, 0, fn(mark_and_count, acc) -> acc + List.first(Map.values(mark_and_count)) end)
  end

  def diagonal_marks(board) do
    [diagonal_values(board) , diagonal_values(Enum.reverse(board))]
  end

  defp diagonal_values(board) do
    Enum.with_index(board)
    |> marks_in_diagonal
  end

  defp marks_in_diagonal(board_with_index) do
    Enum.map(board_with_index, fn({ row, index }) -> Enum.at(row, index) end)
  end

  defp mark_with_fewest_moves(move_counts_per_mark) do
    Enum.min_by(move_counts_per_mark, fn(x) -> Map.values(x) end)
    |> Map.keys
    |> List.to_string
  end

  defp is_true? do
    fn(x) -> x == true end
  end

  defp transpose([[]|_]), do: []
  defp transpose(list) do
    [Enum.map(list, &hd/1) | transpose(Enum.map(list, &tl/1))]
  end
end
