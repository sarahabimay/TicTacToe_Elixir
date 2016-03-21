defmodule TTT.BoardResult do
  alias TTT.Board

  def game_over?(board) do
    not remaining_spaces?(board) or found_winner?(board)
  end

  def winning_mark(board) do
    board
    |> all_lines
    |> find_winning_mark
  end

  def found_winner?(board) do
    board
    |> all_lines
    |> found_winner_in_any_line?
  end

  defp all_lines(board) do
    Board.rows(board) ++ Board.columns(board) ++ Board.diagonals(board)
  end

  defp found_winner_in_any_line?(lines) do
     Enum.any?(lines, fn(line) -> all_same_mark?(line) end)
  end

  defp find_winning_mark(lines) do
    lines
    |> Enum.find(lines, fn(line) -> all_same_mark?(line) end)
    |> List.first
  end

  defp remaining_spaces?(board) do
    board
    |> unique_elements
    |> Enum.any?(fn(elem) -> is_integer(elem) end)
  end

  defp unique_elements(board) do
    Enum.uniq(board)
  end

  defp all_same_mark?([first_mark | rest]) do
    Enum.all?(rest, fn(mark) -> mark == first_mark end)
  end
end
