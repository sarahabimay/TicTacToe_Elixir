defmodule TTT.Console do
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

  def request_board_size do
    @board_size_title <> create_options_for_display(TTT.Options.board_size_options)
    |> display_gets
    |> validate_board_size_choice
  end

  def request_game_type do
    @game_type_title <> create_options_for_display(TTT.Options.game_type_options)
    |> display_gets
    |> validate_game_type_choice
  end

  defp format_board_for_display(board) do
    board
    |> intersperse_column_divider
    |> intersperse_row_divider
    |> append_newline
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

  defp _create_options_for_display(_, []), do: ""
  defp _create_options_for_display(number, options) do
    "[#{number}] #{Enum.at(options, number - 1)}\n" <>
    _create_options_for_display(number + 1, Enum.slice(options, number, Enum.count(options)))
  end
  defp create_options_for_display(options) do
    _create_options_for_display(1, options)
  end

  defp validate_board_size_choice(choice) do
    TTT.Options.validate_board_size_option(choice)
  end

  defp validate_game_type_choice(choice) do
    TTT.Options.validate_game_type_option(choice)
  end

  defp display_puts(message) do
    IO.puts(message)
  end

  defp display_gets(message) do
    IO.gets(message)
  end
end
