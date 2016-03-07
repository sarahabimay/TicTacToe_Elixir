defmodule TTT.Board do
  @x_mark "X"
  @o_mark "O"

  def empty_board(dimension) do
    rows(Enum.to_list(1..dimension*dimension))
  end

  def play_move(board, move, mark) do
    List.replace_at(board, move - 1, mark)
  end

  def next_mark_to_play(board) do
    board
    |> rows
    |> get_move_count_per_mark
    |> mark_with_fewest_moves
  end

  def get_move_count_per_mark(board) do
      [%{@x_mark => position_count_for_mark(board, @x_mark)},
      %{@o_mark => position_count_for_mark(board, @o_mark)}]
  end

  def position_count_for_mark(board, mark) do
    Enum.reduce(board, 0, fn(row, acc) -> acc + mark_count_in_row(row, mark)  end)
  end

  defp mark_count_in_row(row, mark) do
    Enum.count(row, fn(move) -> move == mark end)
  end

  def game_over?(board) do
    not remaining_spaces?(board) or found_winner?(board)
  end

  def winning_mark(board) do
    all_lines = rows(board) ++ columns(board) ++ diagonals(board)
    find_winning_mark(all_lines)
  end

  def found_winner?(board) do
    all_lines = rows(board) ++ columns(board) ++ diagonals(board)
    found_winner_in_any_line?(all_lines)
  end

  def found_winner_in_any_line?(lines) do
     Enum.any?(lines, fn(line) -> all_same_mark?(line) end)
  end

  def find_winning_mark(lines) do
    line = Enum.find(lines, fn(line) -> all_same_mark?(line) end)
    List.first(line)
  end

  def rows(board) do
   Enum.chunk(board, board_dimension(board))
  end

  def columns(board) do
    board
    |> rows
    |> transpose
  end

  def diagonals(board) do
    board
    |> rows
    |> diagonal_marks
  end

  def all_same_mark?([first_mark | rest]) do
    Enum.all?(rest, fn(mark) -> mark == first_mark end)
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
    |> rows
    |> unique_elements
    |> Enum.any?(fn(elem) -> is_integer(elem) end)
  end

  defp unique_elements(board) do
    Enum.uniq(board)
  end

  def mark_with_fewest_moves(move_counts_per_mark) do
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
