defmodule TTT.Console do
  alias TTT.PromptWriter
  alias TTT.PromptReader
  alias TTT.BoardResult

  def request_options(), do: [request_board_size(), request_game_type()]

  def display_board(board) do
    clear_screen()
    PromptWriter.display_board(board)
  end

  def request_board_size() do
    clear_screen()
    PromptReader.request_board_size()
  end

  def request_game_type() do
    clear_screen()
    PromptReader.request_game_type()
  end

  def request_next_move(board) do
    PromptReader.request_next_move(board)
  end

  def announce_result(false, _), do: PromptWriter.announce_draw
  def announce_result(true, board) do
    board
    |> BoardResult.winning_mark
    |> PromptWriter.announce_win
  end

  def clear_screen() do
    IO.ANSI.clear |> IO.write
    IO.ANSI.home |> IO.write
  end
end
