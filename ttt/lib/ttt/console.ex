defmodule TTT.Console do
  alias TTT.Options, as: Options
  @request_move "Please enter a valid move: "
  @board_size_title "Board Size:\n"
  @game_type_title "Game Type:\n"
  @column_divider " | "
  @row_divider  "____________"

  def request_options do
    [request_board_size, request_game_type]
  end

  def display_board(board) do
    board
    |> format_board_for_display
    |> display_puts
  end

  def format_board_for_display(board) do
    board
    |> intersperse_column_divider
    |> intersperse_row_divider
    |> append_newline
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

  def request_game_type(:invalid), do: request_game_type
  def request_game_type(game_type), do: game_type

  def request_next_move(mark) do
   display_gets("Player #{mark}, #{@request_move}")
  end

  defp request_board_size_choice do
    request_board_size_message
    |> display_gets
  end

  def request_board_size_message do
    @board_size_title <> create_options_for_display(TTT.Options.board_size_options)
  end

  defp request_game_type_choice do
    request_game_type_message
    |> display_gets
  end

  defp request_game_type_message do
    @game_type_title <> create_options_for_display(TTT.Options.game_type_options)
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

  defp append_newline(board) do
    Enum.join(board, "\n")
  end

  def create_options_for_display(options) do
    options
    |> one_indexed
    |> Enum.reverse
    |> Enum.reduce("", fn({element, index}, acc) -> "[#{index}] #{element}\n#{acc}" end)
  end

  def one_indexed(options) do
    options
    |> Enum.with_index
    |> Enum.map(fn({element, index}) -> {element, index+1} end)
  end

  defp display_puts(message) do
    IO.puts(message)
  end

  defp display_gets(message) do
    IO.gets(message)
  end
end
