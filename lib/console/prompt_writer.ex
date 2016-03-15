defmodule TTT.PromptWriter do
  alias TTT.BoardDisplay
  alias TTT.Messages

  def display_board(board) do
    board
    |> BoardDisplay.formatted_board
    |> display_puts
  end

  def announce_draw(), do: display_puts(Messages.draw_announcement())

  def announce_win(mark), do: display_puts(Messages.win_announcement() <> mark)

  def closing_down_message(), do: display_puts(Messages.closing_down_message())

  def clear_screen() do
    IO.ANSI.clear |> IO.write
    IO.ANSI.home |> IO.write
  end

  defp display_puts(message) do
    IO.puts(message)
  end
end
