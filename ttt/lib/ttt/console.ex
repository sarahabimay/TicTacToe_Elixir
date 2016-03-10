defmodule TTT.Console do
  alias TTT.Options, as: Options
  alias TTT.Board, as: Board
  alias TTT.BoardPlay, as: BoardPlay
  alias TTT.BoardResult, as: BoardResult
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

  def request_board_size do
    clear_screen
    request_board_size_choice
    |> Options.lookup_board_size
    |> request_board_size
  end

  defp request_board_size(:invalid), do: request_board_size
  defp request_board_size(board_size), do: board_size

  def request_game_type do
    clear_screen
    request_game_type_choice
    |> Options.lookup_game_type
    |> request_game_type
  end

  defp request_game_type(:invalid), do: request_game_type
  defp request_game_type(game_type), do: game_type

  defp request_game_type_choice do
    request_game_type_message
    |> display_gets
  end

  defp request_board_size_choice do
    request_board_size_message
    |> display_gets
  end

  def request_next_move(board) do
    board
    |> next_move
    |> convert_to_integer
    |> validate_next_move(board)
  end

  defp request_next_move(:invalid, board), do: request_next_move(board)
  defp request_next_move(move, _), do: move

  defp validate_next_move(:invalid, board) do
    request_next_move(board)
  end

  defp validate_next_move(move, board) do
    board
    |> BoardPlay.validate_move(move)
    |> request_next_move(board)
  end

  defp next_move(board) do
    board
    |> next_move_message
    |> display_gets
  end

  defp next_move_message(board) do
    mark = BoardPlay.next_mark_to_play(board)
    "Player #{mark}, #{@request_move}"
  end

  def announce_result(false, _), do: announce_draw
  def announce_result(true, board) do
    board
    |> BoardResult.winning_mark
    |> announce_win
  end

  def announce_draw do
    display_puts(@draw_announcement)
  end

  def announce_win(mark) do
    display_puts(@win_announcement <> mark)
  end

  def clear_screen do
    IO.ANSI.clear |> IO.write
    IO.ANSI.home |> IO.write
  end

  defp request_board_size_message do
    @board_size_title <> create_options_for_display(Options.board_size_options)
  end

  defp request_game_type_message do
    @game_type_title <> create_options_for_display(Options.game_type_options)
  end

  defp intersperse_column_divider(board) do
    Enum.map(board, fn(row) -> Enum.join(row, @column_divider) end)
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
    |> options_for_display
  end

  defp one_indexed(options) do
    options
    |> Enum.with_index
    |> Enum.map(fn({element, index}) -> {element, index+1} end)
  end

  defp options_for_display(options) do
    Enum.reduce(options, "", fn({option, index}, acc) -> "[#{index}] #{option}\n#{acc}" end)
  end

  defp display_puts(message) do
    IO.puts(message)
  end

  defp display_gets(message) do
    String.strip(IO.gets(message))
  end

  defp convert_to_integer(move) do
    _convert(Integer.parse(move))
  end

  defp _convert(:error), do: :invalid
  defp _convert({x, _}), do: x
end
