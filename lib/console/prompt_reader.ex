defmodule TTT.Console.PromptReader do
  alias TTT.Console.OptionsDisplay
  alias TTT.Board.BoardPlay
  alias TTT.Messages
  alias TTT.Options

  def request_board_size() do
    request_board_size_message()
    |> display_gets
    |> Options.lookup_board_size
    |> request_board_size
  end

  def request_game_type() do
    request_game_type_message()
    |> display_gets
    |> Options.lookup_game_type
    |> request_game_type
  end

  def request_next_move(board) do
    board
    |> next_move
    |> convert_to_integer
    |> validate_next_move(board)
  end

  def play_again_option() do
    Messages.replay_option()
    |> display_gets()
    |> convert_to_integer
    |> validate_yes_no
  end

  defp request_board_size(:invalid), do: request_board_size()
  defp request_board_size(board_size), do: board_size

  defp request_game_type(:invalid), do: request_game_type()
  defp request_game_type(game_type), do: game_type

  defp request_next_move(:invalid, board), do: request_next_move(board)
  defp request_next_move(move, _), do: move

  defp next_move(board) do
    board
    |> next_move_message
    |> display_gets
  end

  defp next_move_message(board) do
    board
    |> BoardPlay.next_mark_to_play
    |> Messages.request_move_for_mark
  end

  defp validate_next_move(:invalid, board), do: request_next_move(board)

  defp validate_next_move(move, board) do
    board
    |> BoardPlay.validate_move(move)
    |> request_next_move(board)
  end

  defp validate_yes_no(choice) when choice == 1 or choice == 2, do: choice

  defp validate_yes_no(_), do: play_again_option()

  defp request_board_size_message() do
    Messages.board_size_title() <> OptionsDisplay.board_size_options()
  end

  defp request_game_type_message() do
    Messages.game_type_title() <> OptionsDisplay.game_type_options()
  end

  defp display_gets(message), do: String.strip(IO.gets(message))

  defp convert_to_integer(move), do: convert(Integer.parse(move))

  defp convert(:error), do: :invalid
  defp convert({x, _}), do: x
end
