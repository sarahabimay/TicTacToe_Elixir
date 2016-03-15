defmodule TTT.ConsoleGame do
  alias TTT.Console
  alias TTT.Board
  alias TTT.BoardPlay
  alias TTT.BoardResult
  alias TTT.PlayerFactory

  def start_game() do
    Console.clear_screen()
    game_setup()
    |> play_game
  end

  def play_game({board, [current_player | _] = players}) when is_list(board) do
    Console.display_board(board)
    new_board = current_player.next_move(board, Console) |> BoardPlay.play_move(board)
    _play_game(BoardResult.game_over?(new_board), new_board, Enum.reverse(players))
  end

  def _play_game(false, board, players), do: play_game({board, players})
  def _play_game(true, board, _), do: Console.announce_result(BoardResult.found_winner?(board), board)

  defp game_setup() do
    [board_size, game_type] = Console.request_options
    board = Board.empty_board(board_size)
    players = PlayerFactory.select_players(game_type)
    {board, players}
  end
end
