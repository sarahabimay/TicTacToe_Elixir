defmodule TTT.Console do
  alias TTT.Options, as: Options
  alias TTT.Board, as: Board
  @request_move "Please enter a valid move: "
  @board_size_title "Board Size:\n"
  @game_type_title "Game Type:\n"
  @draw_announcement "Game Over! The game was a draw."
  @win_announcement "Game Over! The winner is: "
  @column_divider " | "
  @row_divider  "____________"

  def request_options do
    [request_board_size, request_game_type]
  end

  def display_board(board) do
    board
    |> format_board_for_display
    |> append_newline
    |> display_puts
  end

  def format_board_for_display(board) do
    board
    |> Board.rows
    |> intersperse_column_divider
    |> intersperse_row_divider
    |> append_newline_to_row
  end

  def request_next_move(board, mark) do
    request_next_move(board, mark, validate_next_move(board, display_gets("Player #{mark}, #{@request_move}")))
  end

  def request_next_move(board, mark, :invalid), do: request_next_move(board, mark)
  def request_next_move(board, mark, move), do: move

  def validate_next_move(board, move) do
    Board.validate_move(board, move)
  end

  def request_board_size do
    request_board_size_choice
    |> Options.lookup_board_size
    |> request_board_size
  end

  defp request_board_size(:invalid), do: request_board_size
  defp request_board_size(board_size), do: board_size

  def request_game_type do
    request_game_type_choice
    |> Options.lookup_game_type
    |> request_game_type
  end

  defp request_game_type(:invalid), do: request_game_type
  defp request_game_type(game_type), do: game_type

  defp request_board_size_choice do
    request_board_size_message
    |> display_gets
  end

  defp request_board_size_message do
    @board_size_title <> create_options_for_display(TTT.Options.board_size_options)
  end

  defp request_game_type_choice do
    request_game_type_message
    |> display_gets
  end

  defp request_game_type_message do
    @game_type_title <> create_options_for_display(TTT.Options.game_type_options)
  end

  def announce_result(false, board), do: announce_draw(board)
  def announce_result(true, board) do
    mark = Board.winning_mark(board)
    announce_win(board, mark)
  end

  def announce_draw(board) do
    display_puts(@draw_announcement)
  end

  def announce_win(board, mark) do
    display_puts(@win_announcement <> mark)
  end

  defp intersperse_column_divider(board) do
    Enum.map(board, fn(row) ->
      Enum.join(row, @column_divider)
    end)
  end

  defp intersperse_row_divider(board) do
    board
    |> Enum.intersperse(@row_divider)
  end

  defp append_newline(message) do
    message <> "\n"
  end

  defp append_newline_to_row(board) do
    Enum.join(board, "\n")
  end

  def create_options_for_display(options) do
    options
    |> one_indexed
    |> Enum.reverse
    |> Enum.reduce("", fn({element, index}, acc) -> "[#{index}] #{element}\n#{acc}" end)
  end

  defp one_indexed(options) do
    options
    |> Enum.with_index
    |> Enum.map(fn({element, index}) -> {element, index+1} end)
  end

  defp display_puts(message) do
    IO.puts(message)
  end

  defp display_gets(message) do
    String.strip(IO.gets(message))
  end
end
