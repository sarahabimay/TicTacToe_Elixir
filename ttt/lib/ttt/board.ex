defmodule TTT.Board do
  def empty_board(dimension) do
    Enum.to_list(1..dimension*dimension)
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

  def available_positions(board) do
    Enum.filter(board, is_empty?)
  end

  defp is_empty? do
    fn(position) -> is_integer(position) end
  end

  defp diagonal_marks(board) do
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
