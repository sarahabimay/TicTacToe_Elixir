defmodule TTT.ConsoleGame do
  alias TTT.Console, as: Console
  alias TTT.Board, as: Board
  alias TTT.BoardPlay, as: BoardPlay
  alias TTT.BoardResult, as: BoardResult

  def start_game do
    [board_size, _] = Console.request_options
    Console.clear_screen
    play_game(board_size)
  end

  def play_game(dimension) when is_integer(dimension) do
    board = Board.empty_board(dimension)
    Console.display_board(board)
    play_game(board)
  end

  def play_game(board) when is_list(board) do
    move = Console.request_next_move(board)
    mark = BoardPlay.next_mark_to_play(board)
    new_board = BoardPlay.play_move(board, move, mark)
    Console.clear_screen
    Console.display_board(new_board)
    _play_game(BoardResult.game_over?(new_board), new_board)
  end

  defp _play_game(false, board), do: play_game(board)
  defp _play_game(true, board), do: Console.announce_result(BoardResult.found_winner?(board), board)
end
