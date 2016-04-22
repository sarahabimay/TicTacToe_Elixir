defmodule TTT.ConsoleGame do
  alias TTT.Board.Board
  alias TTT.Board.BoardPlay
  alias TTT.Board.BoardResult
  alias TTT.Player.PlayerFactory

  def start_game(board, display) do
    display.clear_screen()
    game_setup(board, display)
    |> play_game
  end

  def restart_game(false, display), do: display.closing_down_message()
  def restart_game(true, display), do: start_game(Board, display)

  def play_game({board, display, [current_player | _] = players}) when is_list(board) do
    display.display_board(board)
    new_board = play_move(board, display, current_player)
    _play_game(BoardResult.game_over?(new_board), new_board, display, Enum.reverse(players))
  end

  defp _play_game(false, board, display, players), do: play_game({board, display, players})
  defp _play_game(true, board, display, _) do
    display.display_board(board)
    display_result(board, display)
    restart_game(play_again?(display.play_again_option()), display)
  end

  defp game_setup(board, display) do
    new_board = choose_board(board, display)
    players = choose_players(display)
    {new_board, display, players}
  end

  defp choose_board(board, display) do
    display.request_board_size()
    |> board.empty_board
  end

  defp choose_players(display) do
    display.request_game_type()
    |> PlayerFactory.select_players
  end
  defp display_result(board, display) do
    board
    |> BoardResult.found_winner?
    |> display.announce_result(board)
  end

  defp play_move(board, display, player) do
    board
    |> player.next_move(display)
    |> BoardPlay.play_move(board)
  end

  defp play_again?(choice) when choice == 1, do: true
  defp play_again?(choice) when choice == 2, do: false
end
