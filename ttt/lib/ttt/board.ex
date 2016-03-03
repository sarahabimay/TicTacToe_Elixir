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
    remaining_spaces?(board, marks)
  end

  def row_win?(board, marks) do
    Enum.any?(marks, fn(mark) -> row_win_for_mark?(mark, board) == true end)
  end

  def diagonal_win?(board, marks) do
    chunk_board_into_rows(board)
    |> diagonal_marks
    |> row_win?(marks)
  end

  defp remaining_spaces?(board, marks) do
    count_of_all_mark_moves(board, marks) < length board
  end

  defp count_of_all_mark_moves(board, marks) do
    get_move_count_per_mark(board, marks)
    |> total_moves_made
  end

  defp row_win_for_mark?(mark, board) do
   chunk_board_into_rows(board)
   |> Enum.map(fn(row) -> all_the_same_mark?(row, mark) end)
   |> Enum.any?(fn(x) -> x == true end)
  end

  def diagonal_marks(board) do
    diagonal_values(board) ++ diagonal_values(Enum.reverse(board))
  end

  defp diagonal_values(board) do
    add_indexes(board)
    |> marks_in_diagonal
  end

  defp marks_in_diagonal(board_with_index) do
    Enum.map(board_with_index, fn({ row, index }) -> Enum.at(row, index) end)
  end

  defp all_the_same_mark?(row, mark) do
    Enum.all?(row, fn(elem) -> elem == mark end)
  end

  defp total_moves_made(move_count) do
    Enum.reduce(move_count, 0, fn(mark_and_count, acc) -> acc + List.first(Map.values(mark_and_count)) end)
  end

  defp get_move_count_per_mark(board, marks) do
    Enum.map(marks, fn(mark) ->
      %{mark => number_of_moves_with(board, mark)}
    end)
  end

  defp mark_with_fewest_moves(move_counts_per_mark) do
    Enum.min_by(move_counts_per_mark, fn(x) -> Map.values(x) end)
    |> Map.keys
    |> List.to_string
  end

  defp number_of_moves_with(board, mark) do
    Enum.count(board, fn(move) -> move == mark end)
  end

  defp chunk_board_into_rows(board) do
    Enum.chunk(board, round(:math.sqrt(length(board))))
  end

  defp add_indexes(list) do
    Enum.with_index(list)
  end
end
