defmodule TTT.PromptWriter do
  alias TTT.Board
  alias TTT.Messages

  @column_divider " | "
  @row_divider "____________"

  def display_board(board) do
    board
    |> format_board_for_display
    |> append_newline
    |> display_puts
  end

  def announce_draw(), do: display_puts(Messages.draw_announcement())

  def announce_win(mark), do: display_puts(Messages.win_announcement() <> mark)

  def closing_down_message(), do: display_puts(Messages.closing_down_message())

  def format_board_for_display(board) do
    board
    |> Board.rows
    |> intersperse_column_divider
    |> intersperse_row_divider
    |> append_newline_to_row
  end

  def clear_screen() do
    IO.ANSI.clear |> IO.write
    IO.ANSI.home |> IO.write
  end

  defp intersperse_column_divider(board) do
    Enum.map(board, fn(row) -> Enum.join(row, @column_divider) end)
  end

  defp intersperse_row_divider(board), do: Enum.intersperse(board, @row_divider)

  defp append_newline(message), do: message <> "\n"

  defp append_newline_to_row(board), do: Enum.join(board, "\n")

  defp display_puts(message) do
    IO.puts(message)
  end
end
