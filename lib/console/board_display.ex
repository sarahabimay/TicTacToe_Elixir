defmodule TTT.BoardDisplay do
  alias TTT.Board
  def formatted_board(board) do
    board
    |> format_board
    |> append_newline
  end

  def format_board(board) do
    board
    |> Board.rows
    |> intersperse_column_divider
    |> intersperse_row_divider
    |> append_newline_to_row
  end

  defp intersperse_column_divider(board) do
    Enum.map(board, fn(row) -> Enum.join(row, " | ") end)
  end

  defp intersperse_row_divider(board), do: Enum.intersperse(board, "____________")

  defp append_newline(message), do: message <> "\n"

  defp append_newline_to_row(board), do: Enum.join(board, "\n")

end
