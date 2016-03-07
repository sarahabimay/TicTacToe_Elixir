defmodule TTT.Board do
  def empty_board(dimension) do
    Enum.chunk(Enum.to_list(1..dimension*dimension), dimension)
  end

  def play_move(board, move, mark) do
    board
    |> replace_at(mark, matrix_row_index(move, board), matrix_column_index(move, board))
  end


  def next_mark_to_play(board, marks) do
    board
    |> get_move_count_per_mark(marks)
    |> mark_with_fewest_moves
  end

  def game_over?(board) do
    not remaining_spaces?(board) or found_winner?(board)
  end

  def winning_mark(board) do
    winning_mark_in_row(board) <>
     winning_mark_in_column(board) <>
      winning_mark_in_diagonal(board)
  end

  def found_winner?(board) do
    column_win?(board) or found_winner_in_row?(board) or diagonal_win?(board)
  end

  defp replace_at(board, mark, row_index, column_index) do
    board
    |> List.update_at(column_index, &(List.replace_at(&1, row_index - 1, mark)))
  end

  defp matrix_row_index(position, board) do
    div(position, board_dimension(board))
  end

  defp matrix_column_index(position, board) do
    rem(position, board_dimension(board))
  end

  defp winning_mark_in_row([]), do: ""
  defp winning_mark_in_row([row | tail]) do
    if not all_same_mark?([mark | _] = row) do
      winning_mark_in_row(tail)
    else
      mark
    end
  end

  defp winning_mark_in_diagonal(board) do
    board
    |> diagonal_marks
    |> winning_mark_in_row
  end

  defp winning_mark_in_column(board) do
    board
    |> transpose
    |> winning_mark_in_row
  end
  def all_same_mark?([mark | t]) do
    Enum.all?(t, fn(move) -> move == mark end)
  end

  def column_win?(board) do
    board
    |> transpose
    |> found_winner_in_row?
  end

  def diagonal_win?(board) do
    board
    |> diagonal_marks
    |> found_winner_in_row?
  end

  defp found_winner_in_row?([], all_same), do: all_same
  defp found_winner_in_row?(_, true), do: true
  defp found_winner_in_row?([head | tail], false) do
    found_winner_in_row?(tail, all_same_mark?(head))
  end
  def found_winner_in_row?(board) do
    found_winner_in_row?(board, false)
  end

  def diagonal_marks(board) do
    [diagonal_values(board), diagonal_values(Enum.reverse(board))]
  end

  defp diagonal_values(board) do
    board
    |> Enum.with_index
    |> marks_in_diagonal
  end

  defp marks_in_diagonal(board_with_index) do
    Enum.map(board_with_index, fn({ row, index }) -> Enum.at(row, index) end)
  end

  defp remaining_spaces?(board) do
    board
    |> unique_elements
    |> Enum.any?(fn(elem) -> is_integer(elem) end)
  end

  defp unique_elements(board) do
    Enum.uniq(List.flatten(board))
  end

  defp get_move_count_per_mark(board, marks) do
    Enum.map(marks, fn(mark) ->
      %{mark => position_count_for_mark(board, mark)}
    end)
  end

  defp position_count_for_mark(board, mark) do
    Enum.reduce(board, 0, fn(row, acc) -> acc + mark_count_in_row(row, mark)  end)
  end

  defp mark_count_in_row(row, mark) do
    Enum.count(row, fn(move) -> move == mark end)
  end

  defp mark_with_fewest_moves(move_counts_per_mark) do
    Enum.min_by(move_counts_per_mark, fn(x) -> Map.values(x) end)
    |> Map.keys
    |> List.to_string
  end

  defp transpose([[]|_]), do: []
  defp transpose(list) do
    [Enum.map(list, &hd/1) | transpose(Enum.map(list, &tl/1))]
  end

  def board_dimension(board) do
    board
    |> List.flatten
    |> length
    |> :math.sqrt
    |> round
  end
end
