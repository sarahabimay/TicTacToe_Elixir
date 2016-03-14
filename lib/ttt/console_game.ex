defmodule TTT.ConsoleGame do
  alias TTT.Console
  alias TTT.Board
  alias TTT.BoardPlay
  alias TTT.BoardResult
  alias TTT.PlayerFactory

  def start_game(false), do: Console.closing_down_message()
  def start_game(true), do: start_game()

  def start_game() do
    Console.clear_screen()
    game_setup()
    |> play_game
  end

  def play_game({board, [current_player | _] = players}) when is_list(board) do
    Console.display_board(board)
    new_board = play_turn_on_board(board, current_player)
    _play_game(BoardResult.game_over?(new_board), new_board, Enum.reverse(players))
  end

  def _play_game(false, board, players), do: play_game({board, players})
  def _play_game(true, board, _) do
    Console.display_board(board)
    display_result(board)
    start_game(play_again?(Console.play_again_option()))
  end

  def display_result(board) do
    board
    |> BoardResult.found_winner?
    |> Console.announce_result(board)
  end

  defp play_turn_on_board(board, player) do
    board
    |> player.next_move(Console)
    |> BoardPlay.play_move(board)
  end

  defp play_again?(choice) when choice == 1, do: true
  defp play_again?(choice) when choice == 2, do: false

  defp game_setup() do
    [board_size, game_type] = Console.request_options
    board = Board.empty_board(board_size)
    players = PlayerFactory.select_players(game_type)
    {board, players}
  end
end
