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
    chunk_board_into_rows(board)
    |> remaining_spaces?(marks)
  end

  def found_winner?(board, marks) do
    two_d_board = chunk_board_into_rows(board)
    column_win?(two_d_board, marks) or row_win?(two_d_board, marks) or diagonal_win?(two_d_board, marks)
  end

  defp column_win?(board, marks) do
    transpose(board)
    |> row_win?(marks)
  end

  defp row_win?(board, marks) do
    Enum.any?(marks, fn(mark) -> row_win_for_mark?(mark, board) == true end)
  end

  defp diagonal_win?(board, marks) do
    diagonal_marks(board)
    |> row_win?(marks)
  end

  defp remaining_spaces?(board, marks) do
    count_of_all_mark_moves(board, marks) < length(board)
  end

  defp count_of_all_mark_moves(board, marks) do
    get_move_count_per_mark(board, marks)
    |> total_moves_made
  end

  defp diagonal_marks(board) do
    [diagonal_values(board) , diagonal_values(Enum.reverse(board))]
  end

  defp diagonal_values(board) do
    add_indexes(board)
    |> marks_in_diagonal
  end

  defp marks_in_diagonal(board_with_index) do
    Enum.map(board_with_index, fn({ row, index }) -> Enum.at(row, index) end)
  end

  defp row_win_for_mark?(mark, board) do
   rows_with_all_same_mark?(mark, board)
   |> any_wins_found?
  end

  defp rows_with_all_same_mark?(mark, board) do
    Enum.map(board, fn(row) -> winning_row?(row, mark) end)
  end

  defp winning_row?(row, mark) do
    Enum.all?(row, fn(elem) -> elem == mark end)
  end

  defp any_wins_found?(winners) do
    Enum.any?(winners, fn(x) -> x == true end)
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

  defp transpose([[]|_]), do: []
  defp transpose(list) do
    [Enum.map(list, &hd/1) | transpose(Enum.map(list, &tl/1))]
  end
end
